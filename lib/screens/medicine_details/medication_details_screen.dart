import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/themes/app_colors.dart';
import 'package:gerenciamento_medicamentos/models/medicine.dart';
import 'package:gerenciamento_medicamentos/themes/app_text_styles.dart';

class MedicineDetailsScreen extends StatelessWidget {

  MedicineDetailsScreen(this.medicine);

  final Medicine medicine;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(medicine.name,
            style: TextStyles.titleAppBar),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/edit_medicine', arguments: medicine);
              }
          )
        ],
      ),
      backgroundColor: ColorsApp.WHITE,
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Carousel(
              images: medicine.images.map((url){
                return NetworkImage(url);
              }).toList(),
              dotSize: 4,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              dotColor: ColorsApp.BLUE,
              autoplay: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    'Nome do medicamento:',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),

                Text(
                  medicine.name,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 8),
                  child: Text(
                    'Descri????o:',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Text(
                  medicine.type,
                  style: const TextStyle(
                      fontSize: 18
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}