import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sample/database/database_helper.dart';
import 'package:flutter_sample/database/user.dart';
import 'package:flutter_sample/widgets/location_text.dart';
import 'package:flutter_sample/utils/preferences_util.dart';
import 'package:flutter_sample/widgets/media_selected_buttons.dart';
import 'package:flutter_sample/widgets/platform/event_channel_widget.dart';
import 'package:flutter_sample/widgets/platform/message_channel_widget.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  static const String tag = '[MainApp]';
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  late UserProvider _userProvider;

  String? _selectedFilePath;
  bool _isFirstAccess = false;
  User? _user;

  Future<void> _init() async {
    _userProvider =
        UserProvider(database: await _databaseHelper.getDatabaseInstance());
    _userProvider.insert(const User(id: null, name: '플러터', age: 7));
  }

  @override
  void initState() {
    super.initState();

    _init();

    final preferences = PreferencesUtils();
    preferences.getFirstAccess().then((isFirstAccess) {
      setState(() {
        log('$tag isFirstAccess=$isFirstAccess');
        _isFirstAccess = isFirstAccess;

        if (_isFirstAccess) {
          preferences.setFirstAcces();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(_isFirstAccess ? '첫 번째 접근이에요! 환영합니다.' : '환영합니다.'),
              ),
              const LocationText(),
              MediaSelectedButtons(
                onRetrieve: (XFile file) =>
                    setState(() => _selectedFilePath = file.path),
                onSelected: (XFile? file) =>
                    setState(() => _selectedFilePath = file?.path),
              ),
              const SharedPreferenceButtons(),
              const MessageChannelWidget(),
              const EventChannelWidget(),
              ElevatedButton(
                onPressed: () {
                  _userProvider.getAll().then((users) {
                    setState(() {
                      log('$tag users=$users');
                      _user = users.first;
                    });
                  });
                },
                child: const Text('User 정보 가져오기'),
              ),
              Text('User=$_user'),
              _ImageWidget(path: _selectedFilePath),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  final String? _path;

  const _ImageWidget({
    required String? path,
  }) : _path = path;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: _path == null
          ? const Text('Not selected media.')
          : Image.file(
              File(_path),
              fit: BoxFit.cover,
              width: 200,
              height: 200,
            ),
    );
  }
}

class SharedPreferenceButtons extends StatelessWidget {
  const SharedPreferenceButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            PreferencesUtils().removeFirstAccess().then((isSuccess) {
              final message = isSuccess ? '초기화 성공!' : '실패';

              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            });
          },
          child: const Text('접근 초기화'),
        ),
      ],
    );
  }
}
