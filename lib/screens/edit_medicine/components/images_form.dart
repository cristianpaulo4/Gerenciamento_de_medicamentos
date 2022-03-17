import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/colors.dart';
import 'package:gerenciamento_medicamentos/models/medicine.dart';
import 'package:gerenciamento_medicamentos/screens/edit_medicine/components/image_source_sheet.dart';

class ImagesForm extends StatelessWidget {

  const ImagesForm(this.medicine);

  final Medicine medicine;

  @override
  Widget build(BuildContext context) {
    print('################');
    print(medicine);
    print('#################');
    return FormField<List<dynamic>>(
      initialValue: List.from(medicine.images),
      builder: (state){

        void onImageSelected(File file){
          state.value.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

          return AspectRatio(
            aspectRatio: 1,
            child: Carousel(
              images: state.value.map<Widget>((image){
                return Stack(
                  fit: StackFit.expand,
                  children:<Widget>[
                    if(image != Null)
                      Image.network(image, fit: BoxFit.cover,)
                    else
                      Image.file(image as File, fit: BoxFit.cover,),
                     Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          icon: const Icon(Icons.remove),
                          color: Colors.red,
                        onPressed: () {
                          state.value.remove(image);
                          state.didChange(state.value);
                        },
                      ),
                    )
                  ],
                );
              }).toList()..add(
                  Material(
                    color: Colors.grey[100],
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      color: Colors.blueAccent,
                      iconSize: 50,
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) => ImageSourceSheet(
                              onImageSelected: onImageSelected,
                            )
                        );
                      },
                    ),
                  )
              ),
              dotSize: 4,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              dotColor: ColorsApp.blue,
              autoplay: false,
            ),
          );

      },
    );
  }
}
