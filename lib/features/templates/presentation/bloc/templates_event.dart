part of 'templates_bloc.dart';

@immutable
abstract class TemplatesEvent {}

class TemplatesEventLoadMore extends TemplatesEvent {}

class TemplatesEventSendByID extends TemplatesEvent {
  final String id;

  TemplatesEventSendByID(this.id);
}
