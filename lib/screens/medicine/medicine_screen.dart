import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/common/custom_drawer/custom_drawer.dart';
import 'package:gerenciamento_medicamentos/models/medicine.dart';
import 'package:gerenciamento_medicamentos/models/medicine_manager.dart';
import 'package:gerenciamento_medicamentos/screens/medicine/components/medicine_list_tile.dart';
import 'package:gerenciamento_medicamentos/screens/medicine/components/search_dialog.dart';
import 'package:provider/provider.dart';

class MedicineScreen extends StatelessWidget {
  const MedicineScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer<MedicineManager>(
          builder: (_, medicineManager, __){
            if(medicineManager.search.isEmpty){
              return const Text('Medicamentos');
            } else {
              return LayoutBuilder(
                builder: (_, constraints){
                  return GestureDetector(
                    onTap: () async {
                      final search = await showDialog<String>(context: context,
                          builder: (_) => SearchDialog(medicineManager.search));
                      if(search != null){
                        medicineManager.search = search;
                      }
                    },
                    child: Container(
                        width: constraints.biggest.width,
                        child: Text(
                          medicineManager.search,
                          textAlign: TextAlign.center,
                        )
                    ),
                  );
                },
              );
            }
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<MedicineManager>(
            builder: (_, medicineManager, __){
              if(medicineManager.search.isEmpty){
                return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    final search = await showDialog<String>(context: context,
                        builder: (_) => SearchDialog(medicineManager.search));
                    if(search != null){
                      medicineManager.search = search;
                    }
                  },
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () async {
                    medicineManager.search = '';
                  },
                );
                    }
            },
          )
        ],
      ),

      body: Consumer<MedicineManager>(
        builder: (_ ,medicineManager, __){
          final filteredMedicine = medicineManager.filteredMedicine;
          return ListView.builder(
            padding: const EdgeInsets.all(4),
              itemCount: filteredMedicine.length,
              itemBuilder: (_, index){
                return ListTile(
                  title: MedicineListTile(filteredMedicine[index]),
                );
            }
          );
        },
      ),

    );
  }
}


