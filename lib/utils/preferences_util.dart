import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtils {
  PreferencesUtils._();
  static final PreferencesUtils _instance = PreferencesUtils._();

  static const String tag = '[PreferencesUtils]';

  static const String _keyFirstAccess = 'key_first_access';

  factory PreferencesUtils() => _instance;

  Future<bool> getFirstAccess() async {
    final preferences = await SharedPreferences.getInstance();
    final isFirstAccess = preferences.getBool(_keyFirstAccess);
    log('$tag getFirstAccess(): isFirstAccess=$isFirstAccess');
    return isFirstAccess ?? true;
  }

  Future<bool> setFirstAcces() async {
    final preferences = await SharedPreferences.getInstance();
    final isSuccess = preferences.setBool(_keyFirstAccess, false);
    log('$tag setFirstAcces(): isSuccess=$isSuccess');
    return isSuccess;
  }

  Future<bool> removeFirstAccess() async {
    final preferences = await SharedPreferences.getInstance();
    final isSuccess = preferences.remove(_keyFirstAccess);
    log('$tag removeFirstAccess(): isSuccess=$isSuccess');
    return isSuccess;
  }
}
