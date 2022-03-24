import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/models/medicine.dart';
import 'package:gerenciamento_medicamentos/screens/medicine_details/medication_details_screen.dart';
import 'package:gerenciamento_medicamentos/themes/app_colors.dart';
import 'package:gerenciamento_medicamentos/themes/app_text_styles.dart';

class MedicineListTile extends StatelessWidget {
  const MedicineListTile(this.medicine);

  final Medicine medicine;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MedicineDetailsScreen(medicine)));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 100,
            padding: const EdgeInsets.all(2),
            child: Row(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(medicine.images.first),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(medicine.name, style: TextStyles.titleSize1),
                      const SizedBox(height: 1),
                      Text(
                        'Detalhes...',
                        style: TextStyles.titleSize2,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete,
                    color: ColorsApp.RED,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
