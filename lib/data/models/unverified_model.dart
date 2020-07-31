
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:zenithbankkyc/domain/entities/unverified_account.dart';
import 'package:zenithbankkyc/domain/entities/unverified_account_response.dart';

class UnverifiedModel extends UnVerifiedAccountResponse {
  UnverifiedModel({
    @required int responseCode,
    @required String message,
    @required List<UnverifiedAccount> data,
}) : super(responseCode, message,data);

  factory UnverifiedModel.fromJson({@required Map<String, dynamic> json}) {
    return UnverifiedModel(
        responseCode: json['ResponseCode'],
        message: (json['Message']),
        data: (json['Data'] as List).map((items) => UnverifiedAccount.fromJson(items)).toList());

  }

  UnverifiedAccount fromJson(Map<String, dynamic> data){

    return UnverifiedAccount(data['Id'], data['AccountNumber'], data['AccountHolderType'], data['AccountType'], data['ClassCode'], data['BranchNo'], data['AccountName'], data['ResidentialAddress'], data['City'], data['State'], data['EmailAddress'], data['PhoneNumber'], data['FirstName'], data['LastName'], data['Sex'], data['DateOfBirth'], data['Title'], data['StateofOrigin'], data['CountryofOrigin'], data['Occupation'], data['Status'], data['CreationFlag'], data['FamilyStatus'], data['BVN'], data['Create_dt']);

  }

}


class UnverifiedAccountModel extends Equatable {
  final int id;
  final String accountNumber;
  final String accountHolderType;
  final String accountType;
  final int classCode;
  final String branchNo;
  final String accountName;
  final String residentialAddress;
  final String city;
  final String state;
  final String emailAddress;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String sex;
  final String dateOfBirth;


  final String title;
  final String stateofOrigin;
  final String countryofOrigin;
  final String occupation;
  final String status;
  final String creationFlag;
  final String familyStatus;
  final String bVN;
  final String create_dt;


  UnverifiedAccountModel(
      this.id,
      this.accountNumber,
      this.accountHolderType,
      this.accountType,
      this.classCode,
      this.branchNo,
      this.accountName,
      this.residentialAddress,
      this.city,
      this.state,
      this.emailAddress,
      this.phoneNumber,
      this.firstName,
      this.lastName,
      this.sex,
      this.dateOfBirth,
      this.title,
      this.stateofOrigin,
      this.countryofOrigin,
      this.occupation,
      this.status,
      this.creationFlag,
      this.familyStatus,
      this.bVN,
      this.create_dt);

  @override
  List<Object> get props => [id,accountNumber];
}