import 'package:dartz/dartz.dart';
import 'package:zenithbankkyc/core/error/failures.dart';
import 'package:zenithbankkyc/domain/entities/agent_login.dart';
import 'package:zenithbankkyc/domain/entities/agent_login_response.dart';

abstract class AgentLoginRepository {
  Future<Either<Failure, AgentLoginResponse>> login(AgentLogin login);
}