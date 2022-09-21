import 'package:sendify/features/send/domain/entity/send_result_entity.dart';

class SendResultModel extends SendResultEntity {
  SendResultModel(int recipients) : super(recipients);

  factory SendResultModel.fromJson(Map<String, dynamic> json) =>
      SendResultModel(
        json['recipients'],
      );
}
