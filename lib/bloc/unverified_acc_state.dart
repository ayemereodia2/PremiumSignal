part of 'unverified_acc_bloc.dart';

abstract class UnverifiedAccState extends Equatable {
  const UnverifiedAccState();
}

class LoadingUnverifiedAccInitial extends UnverifiedAccState {
  @override
  List<Object> get props => [];
}

class LoadedUnverifiedAccState extends UnverifiedAccState{
     final UnverifiedModel unverifiedList;

  LoadedUnverifiedAccState(this.unverifiedList);

  @override
  List<Object> get props => [unverifiedList];
}

class ErrorState extends UnverifiedAccState {
  final String errorMessage;

  ErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}