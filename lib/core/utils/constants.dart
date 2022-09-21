import 'package:sendify/user_config.dart';

class Constants {
  static const HEADER = {
    'content-type': 'application/json',
    "Authorization": "Basic $ONE_SIGNAL_REST_API_TOKEN",
  };

  static const ONE_SIGNAL_SEND_NOTIFICATION =
      "https://onesignal.com/api/v1/notifications";

  static const ONE_SIGNAL_GET_NOTIFICATIONS =
      "https://onesignal.com/api/v1/notifications?app_id=$ONE_SIGNAL_APP_ID&limit=10";

  static const ONE_SIGNAL_GET_TEMPLATES =
      "https://onesignal.com/api/v1/templates?app_id=$ONE_SIGNAL_APP_ID&offset=0&limit=20";
}
