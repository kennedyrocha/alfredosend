part of 'send_bloc.dart';

@immutable
abstract class SendState {}

class SendInitial extends SendState {}

class SendSuccessResultState extends SendState {
  final SendResultEntity sendResultEntity;

  SendSuccessResultState(this.sendResultEntity);
}

class SendErrorResultState extends SendState {
}

class SendLoadingState extends SendState {
}
