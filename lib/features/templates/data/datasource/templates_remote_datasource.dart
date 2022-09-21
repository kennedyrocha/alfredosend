import 'package:dio/dio.dart';
import 'package:sendify/core/error/exceptions.dart';
import 'package:sendify/core/utils/constants.dart';
import 'package:sendify/core/utils/nothing.dart';
import 'package:sendify/features/templates/data/model/template_model.dart';
import 'package:sendify/features/templates/domain/entity/template_entity.dart';

import '../../../../user_config.dart';

abstract class TemplatesRemoteDataSource {
  Future<TemplatesEntity> getTemplates(int offset);

  Future<Nothing> sendNotificationByTemplate(String notificationId);
}

class TemplatesRemoteDataSourceImpl extends TemplatesRemoteDataSource {
  final Dio _dio;

  TemplatesRemoteDataSourceImpl(this._dio);

  @override
  Future<TemplatesEntity> getTemplates(int offset) async {
    final response = await _dio.get(
      Constants.ONE_SIGNAL_GET_TEMPLATES + "&offset=$offset",
      options: Options(headers: Constants.HEADER),
    );

    if (response.statusCode == 200) {
      List<TemplateModel> list = [];
      response.data['templates'].forEach(
        (template) {
          list.add(
            TemplateModel.fromJson(template),
          );
        },
      );

      return TemplatesEntity(list, response.data['total_count']);
    } else
      throw ServerException();
  }

  @override
  Future<Nothing> sendNotificationByTemplate(String notificationId) async {
    final data = {
      "app_id": "$ONE_SIGNAL_APP_ID",
      "included_segments": ["Subscribed Users"],
      "template_id": notificationId,
    };

    final response = await _dio.post(
      Constants.ONE_SIGNAL_SEND_NOTIFICATION,
      data: data,
      options: Options(headers: Constants.HEADER),
    );


    if (response.statusCode != 200) {
      throw ServerException();
    }

    return Nothing();
  }
}
