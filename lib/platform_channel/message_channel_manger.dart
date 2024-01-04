import 'package:flutter/services.dart';

class MessageChannelManager {
  static const BasicMessageChannel<String> _messageChannel =
      BasicMessageChannel<String>(
          'com.example.flutter_sample/message', StringCodec());

  Future<String?> sendMessage(String message) async {
    try {
      var response = await _messageChannel.send(message);
      return response;
    } on PlatformException catch (e) {
      return "Failed to send message: '${e.message}'.";
    }
  }

  MessageChannelManager() {
    _messageChannel.setMessageHandler((String? message) async {
      // 네이티브에서 받은 메시지를 처리하고 응답을 반환
      if (message == null) {
        return Future.error('response가 null');
      }
      return message;
    });
  }

  void dispose() {
    _messageChannel.setMessageHandler(null);
  }
}
