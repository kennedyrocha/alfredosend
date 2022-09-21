import 'package:sendify/features/analytics/domain/entity/analytics_entity.dart';

class AnalyticsResponseModel extends AnalyticsResponseEntity{
  AnalyticsResponseModel(int totalCount, List<AnalyticsEntity> list) : super(totalCount, list);
  factory AnalyticsResponseModel.fromJson(Map<String, dynamic> json) {
    List<AnalyticsModel> list = [];

    if(json['notifications']!= null) {
      json['notifications'].forEach(
            (notification) {
          list.add(
            AnalyticsModel.fromJson(notification),
          );
        },
      );
    }
    return AnalyticsResponseModel(
      json['total_count'],
      list,
    );
  }
}
class AnalyticsModel extends AnalyticsEntity {
  AnalyticsModel(
      String title,
      bool canceled,
      AnalyticsPlatformDeliveryStats analyticsPlatformDeliveryStats,
      String content,
      String bigImageUrl,
      int totalSuccess,
      int totalFailed)
      : super(title, canceled, analyticsPlatformDeliveryStats, content,
            bigImageUrl, totalSuccess, totalFailed);

  factory AnalyticsModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsModel(
      json['headings']['en'],
      json['canceled'],
      AnalyticsPlatformDeliveryStatsModel.fromJson(
          json['platform_delivery_stats']),
      json['contents']['en'],
      json['big_picture'],
      json['successful'],
      json['failed'],
    );
  }
}

class AnalyticsPlatformDeliveryStatsModel
    extends AnalyticsPlatformDeliveryStats {
  AnalyticsPlatformDeliveryStatsModel(android, ios) : super(android, ios);

  factory AnalyticsPlatformDeliveryStatsModel.fromJson(
      Map<String, dynamic> json) {
    final android = json['android'] != null
        ? new AnalyticsPlatformModel.fromJson(json['android'])
        : null;
    final ios = json['ios'] != null
        ? new AnalyticsPlatformModel.fromJson(json['ios'])
        : null;
    return AnalyticsPlatformDeliveryStatsModel(
      android,
      ios,
    );
  }
}

class AnalyticsPlatformModel extends AnalyticsPlatform {
  AnalyticsPlatformModel(int successful, int failed, int errored)
      : super(successful, failed, errored);

  factory AnalyticsPlatformModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsPlatformModel(
      json['successful'],
      json['failed'],
      json['errored'],
    );
  }
}
