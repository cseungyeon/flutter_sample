import 'package:pigeon/pigeon.dart';

class MessageData {
  final String title;
  final String body;

  MessageData({required this.title, required this.body});
}

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/message.g.dart',
  kotlinOut:
      'android/app/src/main/kotlin/com/example/flutter_sample/pigeon/Messages.g.kt',
  swiftOut: 'ios/Runner/pigeon/Messages.g.swift',
  dartPackageName: 'flutter_sample',
))
@HostApi()
abstract class MessageApi {
  String getHostLanguage();

  @async
  bool sendMessage(MessageData message);
}
