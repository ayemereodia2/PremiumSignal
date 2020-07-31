import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zenithbankkyc/core/error/exceptions.dart';
import 'package:zenithbankkyc/core/util/constants.dart';
import 'package:zenithbankkyc/data/models/unverified_model.dart';
import 'package:http/http.dart' as http;
import 'package:zenithbankkyc/domain/entities/unverified_account.dart';

part 'unverified_acc_event.dart';
part 'unverified_acc_state.dart';

class UnverifiedAccBloc extends Bloc<UnverifiedAccEvent, UnverifiedAccState> {
  UnverifiedAccBloc() : super(LoadingUnverifiedAccInitial());

  @override
  Stream<UnverifiedAccState> mapEventToState(
    UnverifiedAccEvent event,
  ) async* {
    if(event is EmptyEvent){
      yield* _mapLoadingToState();
    }else if (event is OnLocationTappedEvent){
      yield ErrorState('Kyc Loading error');
    }
  }


  Stream<UnverifiedAccState> _mapLoadingToState() async* {
    //yield LoadingUnverifiedAccInitial();
    try{
      final result = await getAllUnverified();
      if(result.responseCode == 200){
        yield LoadedUnverifiedAccState(result);
      }else{
        yield ErrorState('Kyc Loading error');
      }
    } on Exception catch (_) {
        yield ErrorState('Kyc Loading error');
    }
  }


  Future<UnverifiedModel> getAllUnverified() async {
    final response = await http.get(UNV_URL, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return UnverifiedModel.fromJson(json: json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
