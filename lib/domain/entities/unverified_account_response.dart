import 'package:equatable/equatable.dart';
import 'package:zenithbankkyc/domain/entities/unverified_account.dart';

// ignore: must_be_immutable
class UnVerifiedAccountResponse extends Equatable {

  final int responseCode;
  final String message;
  List<UnverifiedAccount> data;

  UnVerifiedAccountResponse(this.responseCode, this.message, this.data);
  @override
  List<Object> get props => [];

}