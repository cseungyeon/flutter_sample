import 'package:flutter/material.dart';
import 'package:flutter_sample/utils/image_manager.dart';
import 'package:image_picker/image_picker.dart';

class MediaSelectedButtons extends StatelessWidget {
  final ImageManager _imageManager = ImageManager();

  final Function(XFile) _onRetrieve;
  final Function(XFile?) _onSelected;

  MediaSelectedButtons({
    super.key,
    required onRetrieve,
    required onSelected,
  })  : _onRetrieve = onRetrieve,
        _onSelected = onSelected;

  @override
  Widget build(BuildContext context) {
    _imageManager.retrieveLostData().then((value) {
      if (value == null) return;
      // _onRetrieve.call(value);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _imageManager
                      .pickMedia()
                      .then((file) => _onSelected.call(file));
                },
                child: const Text('사진/동영상'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                  onPressed: () {
                    _imageManager
                        .pickMediaWithPhotoPicker()
                        .then((file) => _onSelected.call(file));
                  },
                  child: const Text('사진/동영상(PhotoPicker)')),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  _imageManager
                      .pickImageAtCamera()
                      .then((file) => _onSelected.call(file));
                },
                child: const Text('카메라'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
