import 'package:dio/dio.dart';
import 'package:sendify/core/error/exceptions.dart';
import 'package:sendify/core/utils/constants.dart';
import 'package:sendify/features/analytics/data/model/analytics_model.dart';

import '../../../../user_config.dart';

abstract class AnalyticsRemoteDataSource {
  Future<AnalyticsResponseModel> getNotifications(int offset);
}

class AnalyticsRemoteDataSourceImpl extends AnalyticsRemoteDataSource {
  final Dio _dio;

  AnalyticsRemoteDataSourceImpl(this._dio);

  @override
  Future<AnalyticsResponseModel> getNotifications(int offset) async {

    final response = await _dio.get(
      Constants.ONE_SIGNAL_GET_NOTIFICATIONS + "&offset=$offset",
      options: Options(headers: Constants.HEADER),
    );

    if (response.statusCode == 200) {
      return AnalyticsResponseModel.fromJson(response.data);
    } else
      throw ServerException();
  }
}
