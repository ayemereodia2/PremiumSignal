part of 'unverified_acc_bloc.dart';

abstract class UnverifiedAccEvent extends Equatable {
  const UnverifiedAccEvent();
}

class OnLocationTappedEvent extends UnverifiedAccEvent{
  final String address;
  OnLocationTappedEvent(this.address);
  @override
  List<Object> get props => [address];
}

class EmptyEvent extends UnverifiedAccEvent {
  @override
  List<Object> get props => [];

}