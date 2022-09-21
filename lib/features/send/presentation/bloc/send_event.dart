part of 'send_bloc.dart';

@immutable
abstract class SendEvent {}

class SendNotificationEvent extends SendEvent {
  final String title;
  final String content;
  final String androidImageUrl;
  final String iosAttachment;

  SendNotificationEvent(
    this.title,
    this.content,
    this.androidImageUrl,
    this.iosAttachment,
  );
}
