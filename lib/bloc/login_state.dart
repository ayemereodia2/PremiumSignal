part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends OnValidationSuccess {}

class LoadingState extends LoginState {}

class ErrorState extends OnValidationSuccess {
  final String errorMessage;

  ErrorState(this.errorMessage);
}
class LogInSuccessState extends OnValidationSuccess {
  final String information;

  LogInSuccessState(this.information);
}

// ignore: must_be_immutable
class OnValidationSuccess extends LoginState{
  final Username username;
  final Password password;
  final FormzStatus status;
  final String responseCode;
  OnValidationSuccess({this.responseCode, this.username = const Username.pure(), this.password = const Password.pure(), this.status = FormzStatus.pure,});

  OnValidationSuccess onCopyWith({FormzStatus status, Username username, Password password, String responseCode}){

    return OnValidationSuccess(responseCode: this.responseCode, username: username ?? this.username, password: password ?? this.password, status: status ?? this.status,);
  }


}
enum AuthenticationStatus { unknown, authenticated, unauthenticated }





