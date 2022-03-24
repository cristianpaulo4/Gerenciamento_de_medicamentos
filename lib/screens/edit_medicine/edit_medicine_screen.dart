import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/helpers/validators.dart';
import 'package:gerenciamento_medicamentos/models/medicine.dart';
import 'package:gerenciamento_medicamentos/models/medicine_manager.dart';
import 'package:gerenciamento_medicamentos/screens/edit_medicine/components/images_form.dart';
import 'package:gerenciamento_medicamentos/screens/medicine/medicine_screen.dart';
import 'package:gerenciamento_medicamentos/themes/app_colors.dart';
import 'package:gerenciamento_medicamentos/themes/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class EditMedicineScreen extends StatelessWidget {

  SnackBar snackBar;


  EditMedicineScreen(Medicine m, {Key key}) :
        editing = m != null,
        medicine = m != null ? m.clone() : Medicine(), super(key: key);

  final Medicine medicine;
  final bool editing;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider.value(
      value: medicine,
      child: Scaffold(
        appBar: AppBar(
          title: Text(editing ? 'Editar Medicamento' : 'Registrar medicamento',
              style: TextStyles.titleAppBar
          ),
          centerTitle: true,
        ),

        backgroundColor: ColorsApp.WHITE,

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
                          hintText: 'Digite o nome do medicamento:',
                         // border: InputBorder.none
                      ),
                       style: TextStyles.titleSize1,

                    validator:(name){
                        return nameMedicineValid(name);
                    },
                      onSaved: (name) => medicine.name = name,
                    ),

                    TextFormField(
                      initialValue: medicine.type,
                      decoration: const InputDecoration(
                        hintText: 'Digite a descrição:',
                       // border: InputBorder.none
                      ),
                      style: TextStyles.titleSize1,
                      maxLines: null,
                      validator: (description){
                        return DescValid(description);
                      },
                      onSaved: (type) => medicine.type = type,
                    ),

                    const SizedBox(height: 30),
                    
                    Consumer<Medicine>(
                        builder: ( _, medicine, __){
                          return SizedBox(
                              height:45,
                              child: ElevatedButton(
                                  onPressed: !medicine.loading ? () async {
                                    if(formKey.currentState.validate()){
                                      formKey.currentState.save();
                                      await medicine.save();
                                      context.read<MedicineManager>().update(medicine);
                                      snackBar = SnackBar(
                                        content:  Center(
                                            child: Text(
                                                editing ? 'Medicamento Editado \ncom sucesso!!!' : 'Medicamento Salvo \ncom sucesso!!!',
                                                style: TextStyles.titleSize1
                                            )),
                                        duration: const Duration(seconds: 2),
                                        backgroundColor: ColorsApp.BLUE,
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => MedicineScreen()));
                                    }
                                  }: null,

                                  child: medicine.loading
                                   ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation( ColorsApp.WHITE),
                              ):
                                  Text('Salvar',
                                          style: TextStyles.letterBoot
                                  ),
                              ),
                            );
                        },
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),

      ),
    );
  }
}
