import 'package:flutter_sample/src/message.g.dart';

class PigeonManager {
  final MessageApi _api = MessageApi();

  Future<bool> sendMessage(String title, String message) async {
    final messageData = MessageData(title: title, body: message);
    try {
      return _api.sendMessage(messageData);
    } catch (e) {
      return Future.error(e);
    }
  }
}
