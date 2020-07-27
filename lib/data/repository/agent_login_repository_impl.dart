import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:zenithbankkyc/core/error/exceptions.dart';
import 'package:zenithbankkyc/core/error/failures.dart';
import 'package:zenithbankkyc/core/network/network_info.dart';
import 'package:zenithbankkyc/data/datasources/agent_login_remote_data_source.dart';
import 'package:zenithbankkyc/data/models/agent_login_model.dart';
import 'package:zenithbankkyc/domain/entities/agent_login.dart';
import 'package:zenithbankkyc/domain/entities/agent_login_response.dart';
import 'package:zenithbankkyc/domain/repositories/agent_login_repository.dart';

class AgentLoginRepositoryImpl implements AgentLoginRepository {
  final AgentLoginRemoteData agentLoginRemoteData;
  final NetworkInfo networkInfo;

  AgentLoginRepositoryImpl({
    @required this.agentLoginRemoteData,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, AgentLoginModel>> login(AgentLogin login) async {
    if (await networkInfo.isConnected) {
      try {
        //final result = await agentLoginRemoteData.loginAgent(login);
        return Right(await agentLoginRemoteData.loginAgent(login));
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure('Check device connection'));
    }
  }
}
