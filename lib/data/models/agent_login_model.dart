
import 'package:flutter/cupertino.dart';
import 'package:zenithbankkyc/domain/entities/agent_login.dart';
import 'package:zenithbankkyc/domain/entities/agent_login_response.dart';

class AgentLoginModel extends AgentLoginResponse {

  // ignore: non_constant_identifier_names
  AgentLoginModel({@required String ResponseCode, @required String ResponseMessage,})
      :super(ResponseCode:ResponseCode,ResponseMessage:ResponseMessage,);

  factory AgentLoginModel.fromJson({@required Map<String, dynamic> json}){
    return AgentLoginModel(ResponseCode:json['ResponseCode'], ResponseMessage:(json['ResponseMessage']));
  }

  Map<String, dynamic> toJson(){
    return {"ResponseCode":"00", "ResponseMessage":"SUCCESSFUL"};
  }
}