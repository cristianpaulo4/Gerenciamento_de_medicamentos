import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {

  ImageSourceSheet({this.onImageSelected});

  final Function(File) onImageSelected;

  final ImagePicker picker = ImagePicker();

  void editImage(String path){
    ImageCropper();
  }


  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          ElevatedButton(
              onPressed: () async {
               final PickedFile file = await picker.getImage(source: ImageSource.camera);
               editImage(file.path);
              },
              child: const Text('Câmera')
          ),

          ElevatedButton(
              onPressed: () async {
                final PickedFile file = await  picker.getImage(source: ImageSource.gallery);
                editImage(file.path);
              },
              child: const Text('Câmera')
          ),

        ],
      ),
    );
  }
}
