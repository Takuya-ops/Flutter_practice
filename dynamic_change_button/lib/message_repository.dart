import 'package:flutter/services.dart';

class MessageRepository {
  static const platform = MethodChannel('samples.flutter.dev/message');

  Future<void> showToast(msg, score) async {
    final Map params = <String, dynamic>{'message': msg, 'score': score};
    await platform.invokeMethod('showToast', params);
  }
}
