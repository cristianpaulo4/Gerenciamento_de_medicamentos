import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/themes/app_colors.dart';
import 'package:gerenciamento_medicamentos/models/medicine.dart';
import 'package:gerenciamento_medicamentos/models/medicine_manager.dart';
import 'package:gerenciamento_medicamentos/models/user_manager.dart';
import 'package:gerenciamento_medicamentos/screens/edit_medicine/edit_medicine_screen.dart';
import 'package:gerenciamento_medicamentos/screens/login/login_screen.dart';
import 'package:gerenciamento_medicamentos/screens/medicine/medicine_screen.dart';
import 'package:gerenciamento_medicamentos/screens/medicine_details/medication_details_screen.dart';
import 'package:gerenciamento_medicamentos/screens/signup/signup_screen.dart';
import 'package:locally/locally.dart';
import 'package:provider/provider.dart';



Future<void> main() async {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => MedicineManager(),
          lazy: false,
        )
      ],

      child: MaterialApp(
         title: 'Gerenciamento de medicamentos',
         debugShowCheckedModeBanner: false,
         theme: ThemeData(
           primaryColor: ColorsApp.DARK_BLUE,
           appBarTheme: const AppBarTheme(
             elevation: 0
           ),
           scaffoldBackgroundColor: ColorsApp.BLUE,
         ),

        onGenerateRoute: (settings){
          switch(settings.name){

            case '/login':
              return MaterialPageRoute(
                 builder: (_) => LoginScreen()
              );

            case '/signup':
              return MaterialPageRoute(
                  builder: (_) => SignUpScreen()
              );

      //      case '/Medicine':
      //        return MaterialPageRoute(
      //            builder: (_) => MedicineScreen(),
      //        );

            case '/Medicine_Details':
              return MaterialPageRoute(
                  builder: (_) =>  MedicineDetailsScreen(
                      settings.arguments as Medicine
                  )
              );

            case '/edit_medicine':
              return MaterialPageRoute(
                  builder: (_) => EditMedicineScreen(
                    settings.arguments as Medicine
                  )
              );

            case '/':
            default:
              return MaterialPageRoute(
                  builder: (_) => MedicineScreen(),
                  settings: settings
              );

          }
        },

       ),
    );
  }
}
