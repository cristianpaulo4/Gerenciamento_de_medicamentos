import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/models/medicine.dart';
import 'package:gerenciamento_medicamentos/screens/edit_medicine/components/images_form.dart';

class EditMedicineScreen extends StatelessWidget {

  EditMedicineScreen(this.medicine);

  final Medicine medicine;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Medicamento'),
        centerTitle: true,
      ),

      backgroundColor: Colors.white,

      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            ImagesForm(medicine),

            Padding(
                padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    initialValue: medicine.name,
                    decoration: const InputDecoration(
                        hintText: 'Nome do medicamento',
                        border: InputBorder.none
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),

                  validator:(name){
                    if(name.length < 1) {
                      return 'Insira o nome';
                    }
                    return null;
                  },

                  ),

                  TextFormField(
                    initialValue: medicine.type,
                    style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Descrição',
                      border: InputBorder.none
                    ),
                    maxLines: null,
                    validator: (type){
                      if(type.length > 100) {
                        return 'Descrição muito longo';
                      }
                      return null;
                    },
                  ),


                  SizedBox(
                    height:45,
                    child: ElevatedButton(
                        onPressed: () {
                          if(formKey.currentState.validate()){
                            print('Válido!!!');
                          }
                        },
                        child: const Text('Salvar',
                            style: TextStyle(
                                fontSize: 25))),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),

    );
  }
}
