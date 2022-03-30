import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/main.dart';
import 'package:gerenciamento_medicamentos/models/medicine_manager.dart';
import 'package:gerenciamento_medicamentos/screens/login/login_screen.dart';
import 'package:gerenciamento_medicamentos/screens/medicine/components/medicine_list_tile.dart';
import 'package:gerenciamento_medicamentos/screens/medicine/components/search_dialog.dart';
import 'package:gerenciamento_medicamentos/themes/app_text_styles.dart';
import 'package:locally/locally.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MedicineScreen extends StatelessWidget {
   MedicineScreen({Key key}) : super(key: key);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  InitializationSettings initializationSettings;

  init() async {
    androidInitializationSettings = const AndroidInitializationSettings('app_icon',);
    initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification,);
  }

   // selecionar notificação
   Future onSelectNotification(String payLoad) {
     if (payLoad != null) {
       print(payLoad);
     }
   }


   @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Consumer<MedicineManager>(
          builder: (_, medicineManager, __) {
            if (medicineManager.search.isEmpty) {
              return Text('Medicamentos', style: TextStyles.titleAppBar);
            } else {
              return LayoutBuilder(
                builder: (_, constraints) {
                  return GestureDetector(
                    onTap: () async {
                      final search = await showDialog<String>(
                          context: context,
                          builder: (_) => SearchDialog(medicineManager.search));
                      if (search != null) {
                        medicineManager.search = search;
                      }
                    },
                    child: Container(
                        width: constraints.biggest.width,
                        child: Text(
                          medicineManager.search,
                          textAlign: TextAlign.center,
                        )),
                  );
                },
              );
            }
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<MedicineManager>(
            builder: (_, medicineManager, __) {
              if (medicineManager.search.isEmpty) {
                return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    final search = await showDialog<String>(
                        context: context,
                        builder: (_) => SearchDialog(medicineManager.search));
                    if (search != null) {
                      medicineManager.search = search;
                    }
                  },
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () async {
                    medicineManager.search = '';
                  },
                );
              }
            },
          ),
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed('/edit_medicine');
              })
        ],
      ),
      body: Consumer<MedicineManager>(
        builder: (_, medicineManager, __) {
          final filteredMedicine = medicineManager.filteredMedicine;
          return ListView.builder(
              padding: const EdgeInsets.all(4),
              itemCount: filteredMedicine.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: MedicineListTile(filteredMedicine[index]),
                );
              });
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: const Icon(Icons.lock),
      ),
    );
  }
}
