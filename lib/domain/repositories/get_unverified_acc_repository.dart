

import 'package:dartz/dartz.dart';
import 'package:zenithbankkyc/core/error/failures.dart';
import 'package:zenithbankkyc/domain/entities/unverified_account_response.dart';

abstract class GetUnverifiedAccRepository {
  Future<Either<Failure, UnVerifiedAccountResponse>> getUnverified();
}