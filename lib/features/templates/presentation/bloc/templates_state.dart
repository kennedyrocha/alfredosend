part of 'templates_bloc.dart';

@immutable
abstract class TemplatesState {}

class TemplatesInitial extends TemplatesState {}

class TemplatesLoaded extends TemplatesState {
  final List<TemplateEntity> templates;
  final bool hasReachedMax;

  TemplatesLoaded(this.templates, this.hasReachedMax);

}

class TemplateLoading extends TemplatesState {
  final List<TemplateEntity> templates;

  TemplateLoading(this.templates);

}

class TemplateFailedToSendNotification extends TemplatesState {
}

class TemplateSuccessSendNotification extends TemplatesState {
}