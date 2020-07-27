import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:zenithbankkyc/core/error/failures.dart';
import 'package:zenithbankkyc/core/network/network_info.dart';
import 'package:zenithbankkyc/data/datasources/agent_login_remote_data_source.dart';
import 'package:zenithbankkyc/data/models/agent_login_model.dart';
import 'package:zenithbankkyc/data/repository/agent_login_repository_impl.dart';
import 'package:zenithbankkyc/domain/entities/agent_login.dart';
import 'package:zenithbankkyc/domain/entities/agent_login_response.dart';
import 'package:zenithbankkyc/domain/repositories/agent_login_repository.dart';

import '../../../../../core/error/exceptions.dart';

class MockRemoteDataSource extends Mock implements AgentLoginRemoteData{}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main(){
  AgentLoginRepositoryImpl agentLoginRepositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp((){
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockRemoteDataSource();
    agentLoginRepositoryImpl = AgentLoginRepositoryImpl(agentLoginRemoteData: mockRemoteDataSource,networkInfo: mockNetworkInfo);
  });

  test('should check device is online when login is called', () async{
    final agentLogin = AgentLogin(Username: "Nneoma.Okoroafor", Password: "",PINOTP: "");
    // arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    // act
    agentLoginRepositoryImpl.login(agentLogin);
    // assert
    verify(mockNetworkInfo.isConnected);

  });

  test('should return remote data when call to login is successful', () async {
    final agentLogin = AgentLogin(Username: "Nneoma.Okoroafor", Password: "",PINOTP: "");

    final tAgentResponse = AgentLoginModel(ResponseCode: '00', ResponseMessage: 'SUCCESSFUL');
    // arrange
    when(mockRemoteDataSource.loginAgent(any)).thenAnswer((_) async => tAgentResponse);
    // act
    final result = await agentLoginRepositoryImpl.login(agentLogin);
    verify(mockRemoteDataSource.loginAgent(agentLogin));
    expect(result, Right(tAgentResponse));
  });

  test('should return Network failure when device is not connected ', () async {

    final agentLogin = AgentLogin(Username: "Nneoma.Okoroafor", Password: "",PINOTP: "");
    // arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    // act
    final result = await agentLoginRepositoryImpl.login(agentLogin);
    // assert
    expect(result, left(NetworkFailure('Check device connection')));

  });

  test('should return server failure when call to remote data source is unsuccessful', ()  async {

    final agentLogin = AgentLogin(Username: "Nneoma.Okoroafor", Password: "",PINOTP: "");

    //final tAgentResponse = AgentLoginModel(ResponseCode: '00', ResponseMessage: 'SUCCESSFUL');
    // arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

    when(mockRemoteDataSource.loginAgent(any)).thenThrow(Exception());
    // act
    final result = await agentLoginRepositoryImpl.login(agentLogin);
    // assert
    verify(mockRemoteDataSource.loginAgent(any));
    expect(result, left(ServerFailure()));

  });


}