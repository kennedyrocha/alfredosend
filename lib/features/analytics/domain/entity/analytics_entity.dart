class AnalyticsResponseEntity {
  final int totalCount;
  final List<AnalyticsEntity> list;

  AnalyticsResponseEntity(this.totalCount, this.list);
}

class AnalyticsEntity {
  final String title;
  final bool canceled;
  final AnalyticsPlatformDeliveryStats analyticsPlatformDeliveryStats;
  final String content;
  final String bigImageUrl;
  final int totalSuccess;
  final int totalFailed;

  AnalyticsEntity(this.title, this.canceled, this.analyticsPlatformDeliveryStats, this.content, this.bigImageUrl, this.totalSuccess, this.totalFailed);
}

class AnalyticsPlatformDeliveryStats {
  final AnalyticsPlatform android;
  final AnalyticsPlatform ios;

  AnalyticsPlatformDeliveryStats(this.android, this.ios);
}

class AnalyticsPlatform {
  final int successful;
  final int failed;
  final int errored;

  AnalyticsPlatform(this.successful, this.failed, this.errored);
}
