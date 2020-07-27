import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:zenithbankkyc/core/util/constants.dart';
import 'package:zenithbankkyc/data/datasources/agent_login_remote_data_source.dart';
import 'package:zenithbankkyc/data/models/agent_login_model.dart';
import 'package:zenithbankkyc/domain/entities/agent_login.dart';

import '../../../../SampleJson/login.dart';
import '../../../../core/error/exceptions.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  AgentLoginRemoteDataImpl loginRemoteDataImpl;
  MockHttpClient httpClient;

  setUp(() {
    httpClient = MockHttpClient();
    loginRemoteDataImpl = AgentLoginRemoteDataImpl(httpClient: httpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(httpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer(
        (_) async => http.Response(fixture('login_response.json'), 200));
  }

  group('loginAgent', () {
    final tloginParameter = AgentLogin(
        Username: 'Nneoma.Okoroafor', Password: 'Tinaoko@93', PINOTP: '');
    // arrange
    test('should perform a POST on a login URL with application/json header',
        () async {

          setUpMockHttpClientSuccess200();

          // act
      loginRemoteDataImpl.loginAgent(tloginParameter);

      // assert
      verify(httpClient.post(LOGIN_URL,
          headers: {'Content-Type': 'application/json'}, body: jsonEncode(<String, String>{
            'Username': tloginParameter.Username,
            'Password': tloginParameter.Password,
            'PINOTP': tloginParameter.PINOTP,
          })));
    });

    test('should return AgentLoginResponse when statusCode is 200', () async {

      setUpMockHttpClientSuccess200();
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('login_response.json'));

      final model = AgentLoginModel.fromJson(json: jsonMap);
      // act
      final result = await loginRemoteDataImpl.loginAgent(tloginParameter);
      // assert
      expect(result,model);

    });

    test('should throw a ServerException when the responseCode is 404 or other', () async {

      // arrange
      when(httpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));
      // act
      final call =  loginRemoteDataImpl.loginAgent;

      // assert
      expect(() => call(tloginParameter), throwsA(isInstanceOf<ServerException>()));

    });

  });
}
