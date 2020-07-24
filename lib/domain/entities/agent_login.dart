import 'package:flutter/cupertino.dart';

class AgentLogin {
  final String username;
  final String password;
  final String otp;

  AgentLogin({@required this.username, this.password = '', this.otp = ''});
}