part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class UsernameChanged implements LoginEvent{
  final String username;
  UsernameChanged(this.username);
}

class PasswordChanged implements LoginEvent{
  final String password;

  PasswordChanged(this.password);
}

class LoginButtonSubmitted implements LoginEvent {

}