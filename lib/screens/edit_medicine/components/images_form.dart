import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/themes/app_colors.dart';
import 'package:gerenciamento_medicamentos/models/medicine.dart';
import 'package:gerenciamento_medicamentos/screens/edit_medicine/components/image_source_sheet.dart';
import 'package:gerenciamento_medicamentos/themes/app_text_styles.dart';

class ImagesForm extends StatelessWidget {

  const ImagesForm(this.medicine, this.editing);

  final Medicine medicine;

  final bool editing;

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
                       if(editing)
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 120,
                              width: 100,
                              color: ColorsApp.WHITE,
                              child: Column(
                                children: [
                                  IconButton(
                                        color: ColorsApp.RED,
                                        iconSize: 40,
                                        icon: const Icon(Icons.delete),
                                      onPressed: () {

                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Deseja deletar essa imagem?'),

                                                actions: <Widget>[
                                                  AspectRatio(
                                                    aspectRatio: 1,
                                                    child: Image.network(medicine.images.first),
                                                  ),
                                                  SizedBox(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        ElevatedButton.icon(
                                                            onPressed: (){
                                                              Navigator.of(context).pop();
                                                            },

                                                            icon: const Icon(
                                                                Icons.history,
                                                                color: ColorsApp.YELLOW
                                                            ),

                                                            label: const Text('Voltar')),

                                                        ElevatedButton.icon(
                                                          onPressed: () {
                                                            state.value.remove(image);
                                                            state.didChange(state.value);
                                                            Navigator.of(context).pop();
                                                          },
                                                          label: const Text('Deletar'),

                                                          icon: const Icon(
                                                              Icons.delete,
                                                              color: ColorsApp.RED
                                                          ),
                                                        )

                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              );
                                            });

                                      },
                                  ),

                                  Text('Deletar \nImagem',
                                  style: TextStyles.titleSize2,
                                  ),
                                ],
                              ),
                            ),
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
