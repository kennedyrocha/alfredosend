part of 'analytics_bloc.dart';

@immutable
abstract class AnalyticsState {}

class AnalyticsInitial extends AnalyticsState {}

class AnalyticsLoadedNotifications extends AnalyticsState {
  final List<AnalyticsEntity> notifications;
  final bool hasReachedMax;

  AnalyticsLoadedNotifications(this.notifications, this.hasReachedMax);
}

class AnalyticsLoading extends AnalyticsState {
  final List<AnalyticsEntity> notifications;

  AnalyticsLoading(this.notifications);
}