import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/themes/app_colors.dart';
import 'package:gerenciamento_medicamentos/models/medicine.dart';
import 'package:gerenciamento_medicamentos/screens/edit_medicine/components/image_source_sheet.dart';

class ImagesForm extends StatelessWidget {

  const ImagesForm(this.medicine);

  final Medicine medicine;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: List.from(medicine.images),

      validator: (images){
        if(images.isEmpty) {
          return 'Insira ao menos uma imagem';
        }else{
          return null;
        }
      },
      onSaved: (images) => medicine.newImages = images,

      builder: (state){
        void onImageSelected(File file){
          state.value.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

          return Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Carousel(
                  images: state.value.map<Widget>((image){
                    return Stack(
                      fit: StackFit.expand,
                      children:<Widget>[
                        if(image is String)
                          Image.network(image, fit: BoxFit.cover,)
                        else
                          Image.file(image as File, fit: BoxFit.cover,),
                         Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              icon: const Icon(Icons.remove),
                              color: ColorsApp.RED,
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
                        color: ColorsApp.WHITE,
                        child: IconButton(
                          icon: const Icon(Icons.add_a_photo),
                          color: ColorsApp.DARK_BLUE,
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
                  dotColor: ColorsApp.BLUE,
                  autoplay: false,
                ),
              ),

              if(state.hasError)
                Container(
                  margin: const EdgeInsets.only(top: 16, left: 16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    state.errorText,
                    style: const TextStyle(
                      color : ColorsApp.RED,
                    fontSize: 20)
                  ),
                )

            ],
          );

      },
    );
  }
}
