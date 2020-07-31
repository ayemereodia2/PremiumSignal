import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:zenithbankkyc/bloc/password.dart';
import 'package:zenithbankkyc/bloc/username.dart';
import 'package:zenithbankkyc/core/error/exceptions.dart';
import 'package:zenithbankkyc/core/util/constants.dart';

import 'package:http/http.dart' as http;
import 'package:zenithbankkyc/data/models/agent_login_model.dart';
import 'package:zenithbankkyc/domain/entities/agent_login.dart';
import 'package:zenithbankkyc/domain/usecases/staff_login_use_case.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, OnValidationSuccess> {
  final StaffLoginUseCase loginUseCase;
  LoginBloc({@required this.loginUseCase}) : super(LoginInitial());

  @override
  Stream<OnValidationSuccess> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is UsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is PasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginButtonSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }

  OnValidationSuccess _mapUsernameChangedToState(
      UsernameChanged event, OnValidationSuccess state) {
    final username = Username.dirty(event.username);
    return state.onCopyWith(
        status: Formz.validate([state.password, username]), username: username);
  }

  OnValidationSuccess _mapPasswordChangedToState(
      PasswordChanged event, OnValidationSuccess state) {
    final password = Password.dirty(event.password);
    return state.onCopyWith(
        status: Formz.validate([password, state.username]), password: password);
  }

  Stream<OnValidationSuccess> _mapLoginSubmittedToState(
    LoginButtonSubmitted event,
    OnValidationSuccess state,
  ) async* {
    if (state.status.isValidated) {
      yield state.onCopyWith(status: FormzStatus.submissionInProgress);
      try {
        final login = AgentLogin(Username: state.username.value, Password: state.password.value);
        final result = await loginAgent(login);

        if (result.ResponseCode == '00') {
             yield LogInSuccessState(result.ResponseCode);
        } else {
            yield ErrorState('Log In failure');
        }
      } on Exception catch (_) {
        yield state.onCopyWith(status: FormzStatus.submissionFailure);
      }
    }
  }

  Future<AgentLoginModel> loginAgent(AgentLogin login) async {
    final response = await http.post(LOGIN_URL,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'Username': login.Username,
          'Password': login.Password,
          'PINOTP': login.PINOTP,
        }));
    if (response.statusCode == 200) {
      return AgentLoginModel.fromJson(json: json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}


/**

    //          final result =  await loginUseCase.call(Params(login: login));
    //          result.fold((failure) async* {
    //            yield state.onCopyWith(status: FormzStatus.submissionFailure);
    //
    //          }, (success) async* {
    //             yield state.onCopyWith(status: FormzStatus.submissionSuccess);
    //
    //          });
    //        print(result.ResponseCode);
    //        if(result.ResponseCode == '00'){
    //            yield state.onCopyWith(status: FormzStatus.submissionSuccess);
    //          }else{
    //            yield state.onCopyWith(status: FormzStatus.submissionFailure);
    //          }
    //        final login = AgentLogin(
    //            Username: state.username.value, Password: state.password.value);
    //        final result = await loginAgent(login);
    //        print(result.ResponseCode);
    //        if (result.ResponseCode == '00') {
    //          yield state.onCopyWith(status: FormzStatus.submissionSuccess);
    //        } else {
    //          yield state.onCopyWith(status: FormzStatus.submissionFailure);
    **/