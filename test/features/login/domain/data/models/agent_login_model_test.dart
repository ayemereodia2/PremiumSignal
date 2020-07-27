import 'package:flutter_test/flutter_test.dart';
import 'package:zenithbankkyc/data/models/agent_login_model.dart';
import 'package:zenithbankkyc/domain/entities/agent_login.dart';
import 'package:zenithbankkyc/domain/entities/agent_login_response.dart';
import 'dart:convert';

import '../../../../../SampleJson/login.dart';

void main(){
  final tAgentLoginModel = AgentLoginModel(ResponseCode:'00',ResponseMessage:'SUCCESSFUL');
  test('should be a subclass of AgentLogin entity', () async {


    expect(tAgentLoginModel, isA<AgentLoginResponse>());
  });


  group('fromJson', (){

    test('should return a valid json when responseCode is 00', () async {

      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('login_response.json'));
      // act
      final result = AgentLoginModel.fromJson(json: jsonMap);
      // assert

      expect(result, tAgentLoginModel);

    });

  });

  group('toJson', (){

    test('should return a valid Json Map containing proper data', () async {

      // act
      final json = tAgentLoginModel.toJson();
      // assert
      final expected = {"ResponseCode":"00", "ResponseMessage":"SUCCESSFUL"};
      expect(json, expected);
    });
  });

}