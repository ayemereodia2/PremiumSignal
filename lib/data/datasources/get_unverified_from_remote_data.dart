
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:zenithbankkyc/core/error/exceptions.dart';
import 'package:zenithbankkyc/core/util/constants.dart';
import 'package:zenithbankkyc/data/models/unverified_model.dart';

abstract class GetUnverifiedFromRemoteData {
  Future<UnverifiedModel> getAllUnverified();
}


class GetUnverifiedFromRemoteDataImpl implements GetUnverifiedFromRemoteData {

  final http.Client httpClient;

  GetUnverifiedFromRemoteDataImpl({@required this.httpClient});

  @override
  Future<UnverifiedModel> getAllUnverified() async {
    final response = await httpClient.get(UNV_URL);
    if (response.statusCode == 200) {
      return UnverifiedModel.fromJson(json: json.decode(response.body));
    } else {
      throw ServerException();
    }
  }


}