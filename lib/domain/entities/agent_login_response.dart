import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class AgentLoginResponse extends Equatable {
  // ignore: non_constant_identifier_names
  final String ResponseCode;
  // ignore: non_constant_identifier_names
  final String ResponseMessage;

  // ignore: non_constant_identifier_names
  AgentLoginResponse({@required this.ResponseCode, @required this.ResponseMessage});

  @override
  List<Object> get props => [ResponseCode, ResponseMessage];

}
