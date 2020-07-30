import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:zenithbankkyc/core/error/exceptions.dart';
import 'package:zenithbankkyc/core/util/constants.dart';

import 'package:zenithbankkyc/data/models/agent_login_model.dart';
import 'package:zenithbankkyc/domain/entities/agent_login.dart';

abstract class AgentLoginRemoteData {
  Future<AgentLoginModel> loginAgent(AgentLogin login);
}

class AgentLoginRemoteDataImpl implements AgentLoginRemoteData {
  final http.Client httpClient;

  AgentLoginRemoteDataImpl({@required this.httpClient});

  @override
  Future<AgentLoginModel> loginAgent(AgentLogin login) async {
    final response = await httpClient.post(LOGIN_URL,
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
