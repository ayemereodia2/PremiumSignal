
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:zenithbankkyc/core/error/failures.dart';
import 'package:zenithbankkyc/core/network/network_info.dart';
import 'package:zenithbankkyc/data/datasources/get_unverified_from_remote_data.dart';
import 'package:zenithbankkyc/domain/entities/unverified_account_response.dart';
import 'package:zenithbankkyc/domain/repositories/get_unverified_acc_repository.dart';

class GetUnverifiedAccRepositoryImpl implements GetUnverifiedAccRepository {
  final GetUnverifiedFromRemoteData remoteData;
  final NetworkInfo networkInfo;

  GetUnverifiedAccRepositoryImpl({
    @required this.remoteData,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, UnVerifiedAccountResponse>> getUnverified() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteData.getAllUnverified());
    } on Exception {
    return Left(ServerFailure());
    }
    } else {
    return Left(NetworkFailure('Check device connection'));
    }
  }
}