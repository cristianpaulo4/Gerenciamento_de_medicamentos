import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/models/medicine.dart';
import 'package:gerenciamento_medicamentos/screens/edit_medicine/components/images_form.dart';

class EditMedicineScreen extends StatelessWidget {

  const EditMedicineScreen(this.medicine);

  final Medicine medicine;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Medicamento'),
        centerTitle: true,
      ),

      body: ListView(
        children: <Widget>[
          ImagesForm(medicine),
        ],
      ),

    );
  }
}
