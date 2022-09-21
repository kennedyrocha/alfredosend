import 'package:dio/dio.dart';
import 'package:sendify/core/error/exceptions.dart';
import 'package:sendify/core/utils/constants.dart';
import 'package:sendify/features/send/data/model/send_result_model.dart';
import 'package:sendify/user_config.dart';

abstract class SendRemoteDataSource {
  Future<SendResultModel> send(
    String title,
    String content,
    String androidImageUrl,
    String iosAttachment,
  );
}

class SendRemoteDataSourceImpl extends SendRemoteDataSource {
  final Dio _dio;

  SendRemoteDataSourceImpl(this._dio);

  @override
  Future<SendResultModel> send(String title, String content,
      String androidImageUrl, String iosAttachment) async {
    final header = {
      'content-type': 'application/json',
      "Authorization": "Basic $ONE_SIGNAL_REST_API_TOKEN",
    };

    final data = {
      "app_id": "$ONE_SIGNAL_APP_ID",
      "included_segments": ["Subscribed Users"],
      "contents": {"en": "$content"},
      "big_picture": "$androidImageUrl",
      "ios_attachments": {"id1": "$iosAttachment"},
      "headings": {"en": "$title"},
    };

    final response = await _dio.post(
      Constants.ONE_SIGNAL_SEND_NOTIFICATION,
      data: data,
      options: Options(headers: header),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }

    return SendResultModel.fromJson(
      response.data,
    );
  }
}
