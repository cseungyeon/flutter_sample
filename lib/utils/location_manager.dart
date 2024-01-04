import 'dart:developer';

import 'package:geolocator/geolocator.dart';

class LocationManager {
  static const String tag = '[LocationManager]';

  Future<Position> getCurrentLocation() async {
    final isGranted = await _checkPermission();
    if (!isGranted) {
      return Future.error('');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  Future<Position?> getLastLocation() async {
    final isGranted = await _checkPermission();
    if (!isGranted) {
      return Future.error('');
    }
    return await Geolocator.getLastKnownPosition();
  }

  Future<bool> _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    log('$tag checkPermission=$permission');

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('$tag Location permissions are denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log('$tag Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }

    log('$tag Location permissions are granted!');
    return true;
  }
}
