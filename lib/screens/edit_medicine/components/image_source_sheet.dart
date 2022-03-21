import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {

  ImageSourceSheet({this.onImageSelected});

  final Function(File) onImageSelected;

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[


          const SizedBox(height: 10,),

          SizedBox(
            height: 45,
            child: ElevatedButton(
                onPressed: () async {
                 final PickedFile file = await picker.getImage(source: ImageSource.camera);
                 onImageSelected(File(file.path));
                },
                child: const Text('Câmera',
                    style: TextStyle(
                    fontSize: 20)
                  )
            ),
          ),

          const SizedBox(height: 20,),

          SizedBox(
            height: 45,
            child: ElevatedButton(
             onPressed: () async {
                final PickedFile file = await  picker.getImage(source: ImageSource.gallery);
                onImageSelected(File(file.path));
              },
              child: const Text('Galeria',
                  style: TextStyle(
                      fontSize: 20))
            ),
          ),

          const SizedBox(height: 10,),

        ],
      ),
    );
  }
}
