part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends OnValidationSuccess {}

class LoadingState extends LoginState {}

class ErrorState extends LoginState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}
class LogInSuccessState extends LoginState {
  final String information;

  LogInSuccessState(this.information);
}

class OnValidationSuccess extends LoginState{
  final Username username;
  final Password password;
  final FormzStatus status;
  OnValidationSuccess({this.username = const Username.pure(), this.password = const Password.pure(), this.status = FormzStatus.pure,});

  OnValidationSuccess onCopyWith({FormzStatus status, Username username, Password password}){

    return OnValidationSuccess(username: username ?? this.username, password: password ?? this.password, status: status ?? this.status);
  }

}





