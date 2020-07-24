import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:zenithbankkyc/core/error/failures.dart';
import 'package:zenithbankkyc/core/usecase/uses_case.dart';
import 'package:zenithbankkyc/domain/entities/agent_login.dart';
import 'package:zenithbankkyc/domain/entities/agent_login_response.dart';
import 'package:zenithbankkyc/domain/repositories/agent_login_repository.dart';

class StaffLoginUseCase implements UseCase<AgentLoginResponse, Params> {

  final AgentLoginRepository repository;
  StaffLoginUseCase({@required this.repository});

  @override
  Future<Either<Failure, AgentLoginResponse>> call(params) async {
    return await repository.login(params.login);
  }

}


class Params extends Equatable {
  final AgentLogin login;
  Params({@required this.login});

  @override
  List<Object> get props => [login];
}