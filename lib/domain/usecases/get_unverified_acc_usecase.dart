
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:zenithbankkyc/core/error/failures.dart';
import 'package:zenithbankkyc/core/usecase/uses_case.dart';
import 'package:zenithbankkyc/domain/entities/unverified_account_response.dart';
import 'package:zenithbankkyc/domain/repositories/get_unverified_acc_repository.dart';
import 'package:zenithbankkyc/domain/usecases/staff_login_use_case.dart';

class GetUnverifiedAccUseCase implements UseCase<UnVerifiedAccountResponse, NoParams> {

  final GetUnverifiedAccRepository repository;
  GetUnverifiedAccUseCase({@required this.repository});

  @override
  Future<Either<Failure, UnVerifiedAccountResponse>> call(NoParams params) async {
    return await repository.getUnverified();
  }


}