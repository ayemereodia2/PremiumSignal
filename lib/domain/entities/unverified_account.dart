import 'package:equatable/equatable.dart';

class UnverifiedAccount extends Equatable {
  final String Id;
  final String AccountNumber;
  final String AccountHolderType;
  final String AccountType;
  final String ClassCode;
  final String BranchNo;
  final String AccountName;
  final String ResidentialAddress;
  final String City;
  final String State;
  final String EmailAddress;
  final String PhoneNumber;
  final String FirstName;
  final String LastName;
  final String Sex;
  final String DateOfBirth;

  final String Title;
  final String StateofOrigin;
  final String CountryofOrigin;
  final String Occupation;
  final String Status;
  final String CreationFlag;
  final String FamilyStatus;
  final String BVN;
  final String Create_dt;

  UnverifiedAccount(
      this.Id,
      this.AccountNumber,
      this.AccountHolderType,
      this.AccountType,
      this.ClassCode,
      this.BranchNo,
      this.AccountName,
      this.ResidentialAddress,
      this.City,
      this.State,
      this.EmailAddress,
      this.PhoneNumber,
      this.FirstName,
      this.LastName,
      this.Sex,
      this.DateOfBirth,
      this.Title,
      this.StateofOrigin,
      this.CountryofOrigin,
      this.Occupation,
      this.Status,
      this.CreationFlag,
      this.FamilyStatus,
      this.BVN,
      this.Create_dt);

  factory UnverifiedAccount.fromJson(Map<String, dynamic> data) {
    return UnverifiedAccount(
        data['Id'],
        data['AccountNumber'],
        data['AccountHolderType'],
        data['AccountType'],
        data['ClassCode'],
        data['BranchNo'],
        data['AccountName'],
        data['ResidentialAddress'],
        data['City'],
        data['State'],
        data['EmailAddress'],
        data['PhoneNumber'],
        data['FirstName'],
        data['LastName'],
        data['Sex'],
        data['DateOfBirth'],
        data['Title'],
        data['StateofOrigin'],
        data['CountryofOrigin'],
        data['Occupation'],
        data['Status'],
        data['CreationFlag'],
        data['FamilyStatus'],
        data['BVN'],
        data['Create_dt']);
  }

  @override
  List<Object> get props => [Id, AccountNumber];
}
