import 'dart:developer';

import 'package:flutter/services.dart';

import 'dart:async';

class EventChannelManager {
  static const String tag = '[EventChannelManager]';
  static const EventChannel _eventChannel =
      EventChannel('com.example.flutter_sample/events');
  late StreamController<String> _eventController;

  EventChannelManager() {
    _eventController = StreamController<String>();
    _startEventChannel();
  }

  Stream<String> get eventStream => _eventController.stream;

  void _startEventChannel() {
    _eventChannel.receiveBroadcastStream().listen(
      (dynamic event) {
        log('$tag ${event.toString()}');
        _eventController.add(event.toString());
      },
      onError: (dynamic error) {
        log('$tag error=$error');
      },
    );
  }

  void dispose() {
    _eventController.close();
  }
}
