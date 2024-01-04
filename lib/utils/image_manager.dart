import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:image_picker_android/image_picker_android.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

class ImageManager {
  static const String tag = "[ImageManager]";

  final ImagePicker _picker = ImagePicker();
  final ImagePickerPlatform _pickerImplementation =
      ImagePickerPlatform.instance;

  Future<XFile> pickMedia() async {
    final media = await _picker.pickMedia();
    return _handleEvent(media);
  }

  Future<XFile> pickMediaWithPhotoPicker() async {
    if (_pickerImplementation is ImagePickerAndroid) {
      // picker 구현체가 Andorid 일 때만 PhotoPicker 값을 true로 변경
      (_pickerImplementation).useAndroidPhotoPicker = true;
      final selectedMedia = pickMedia();
      (_pickerImplementation).useAndroidPhotoPicker = false;
      return selectedMedia;
    } else {
      return pickMedia();
    }
  }

  Future<XFile> pickImageAtCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    return _handleEvent(image);
  }

  Future<XFile> _handleEvent(XFile? file) async {
    if (file == null) {
      log('$tag not selected image.');
      return Future.error(Exception('not selected image.'));
    } else {
      log('$tag name=${file.name}, path=${file.path}');
      return file;
    }
  }

  Future<XFile?> retrieveLostData() async {
    if (_pickerImplementation is! ImagePickerAndroid) {
      return null;
    }

    final response = await _picker.retrieveLostData();

    if (response.isEmpty) {
      return null;
    }

    if (response.file == null) {
      log('$tag exception code=${response.exception?.code}');
      return null;
    }

    return response.file;
  }
}
