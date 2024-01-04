import 'package:flutter/material.dart';
import 'package:flutter_sample/utils/location_manager.dart';

class LocationText extends StatefulWidget {
  const LocationText({super.key});

  @override
  State<LocationText> createState() => _LocationTextState();
}

class _LocationTextState extends State<LocationText> {
  final LocationManager _manager = LocationManager();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder(
          future: _manager.getCurrentLocation(),
          builder: (context, snapshot) {
            String message = '위치 값 로딩 중...';
            if (snapshot.hasData) {
              final currentLocation = snapshot.data!;
              message =
                  'lat=${currentLocation.latitude}, lon=${currentLocation.longitude}';
            }
            return Text(message);
          }),
    );
  }
}
