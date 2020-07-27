import 'package:flutter/cupertino.dart';

class AgentLogin {
  // ignore: non_constant_identifier_names
  final String Username;
  // ignore: non_constant_identifier_names
  final String Password;
  // ignore: non_constant_identifier_names
  final String PINOTP;

  // ignore: non_constant_identifier_names
  AgentLogin({@required this.Username, this.Password = '', this.PINOTP = ''});
}