

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super();
}


// General failures
class ServerFailure extends Failure {
  @override
  List<Object> get props => [];
}


class NetworkFailure extends Failure {
  final String message;

  NetworkFailure(this.message);
  @override
  List<Object> get props => [message];
}