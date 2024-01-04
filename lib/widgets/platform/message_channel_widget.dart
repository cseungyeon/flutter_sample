import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sample/platform_channel/message_channel_manger.dart';

class MessageChannelWidget extends StatefulWidget {
  const MessageChannelWidget({super.key});

  @override
  State<MessageChannelWidget> createState() => _MessageChannelWidgetState();
}

class _MessageChannelWidgetState extends State<MessageChannelWidget> {
  final MessageChannelManager _messageChannelManager = MessageChannelManager();

  @override
  void dispose() {
    _messageChannelManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        var response = await _messageChannelManager.sendMessage('하이');
        log('플랫폼으로부터 받은 메시지: response=$response');
      },
      child: const Text('to Native (Message)'),
    );
  }
}
