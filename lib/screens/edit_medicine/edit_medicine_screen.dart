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
              ImagesForm(medicine, editing),

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
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                 children: [
                                  SizedBox(
                                    width: 160.0,
                                    height: 100.0,
                                    child: ElevatedButton(
                                        onPressed: !medicine.loading ? () async {
                                          if(formKey.currentState.validate()){
                                            formKey.currentState.save();
                                            await medicine.save();
                                            context.read<MedicineManager>().update(medicine);
                                            snackBar = SnackBar(
                                              content:  Center(
                                                  child: Text(
                                                      editing ? 'Medicamento Editado!!!' : 'Medicamento Salvo!!!',
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
                                  ),


                                if(editing)  SizedBox(
                                    width: 160.0,
                                    height: 100.0,
                                    child: ElevatedButton.icon(

                                      onPressed: () {

                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(medicine.name),
                                                content: Text(medicine.type),
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

                                                            label: Text('Voltar')),

                                                        ElevatedButton.icon(
                                                          onPressed: () {
                                                            context.read<MedicineManager>().delete(medicine);
                                                           Navigator.push(context, MaterialPageRoute(builder: (context) => MedicineScreen()));
                                                           //TODO: Arruma navegação, esta voltando...
                                                          },
                                                          label: Text('Deletar'),

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

                                      label: Text('Deletar',
                                          style: TextStyles.letterBoot
                                      ),

                                      icon: const Icon(
                                        Icons.delete,
                                            color: ColorsApp.RED
                                      ),

                                      style: ElevatedButton.styleFrom(
                                        primary: ColorsApp.BLACK
                                      ),

                                    ),
                                  )

                                ],
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
