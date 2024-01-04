import 'package:flutter/material.dart';
import 'package:flutter_sample/platform_channel/event_channel_manager.dart';

class EventChannelWidget extends StatefulWidget {
  const EventChannelWidget({super.key});

  @override
  State<EventChannelWidget> createState() => _EventChannelWidgetState();
}

class _EventChannelWidgetState extends State<EventChannelWidget> {
  final EventChannelManager _eventChannelManager = EventChannelManager();

  @override
  void dispose() {
    _eventChannelManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder(
            stream: _eventChannelManager.eventStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  'EventChannel: ${snapshot.data}',
                  style: const TextStyle(fontSize: 20),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
