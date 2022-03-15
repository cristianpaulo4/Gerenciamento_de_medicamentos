import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/app_routes.dart';
import 'package:gerenciamento_medicamentos/colors.dart';
import 'package:gerenciamento_medicamentos/models/medicine_manager.dart';
import 'package:gerenciamento_medicamentos/models/user_manager.dart';
import 'package:gerenciamento_medicamentos/screens/base/base_screen.dart';
import 'package:gerenciamento_medicamentos/screens/login/login_screen.dart';
import 'package:gerenciamento_medicamentos/screens/medicine/medicine_screen.dart';
import 'package:gerenciamento_medicamentos/screens/register/register.screen.dart';
import 'package:gerenciamento_medicamentos/screens/signup/signup_screen.dart';
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
           primaryColor: ColorsApp.blueGrey,
           appBarTheme: const AppBarTheme(
             elevation: 0
           ),
           scaffoldBackgroundColor: ColorsApp.blue,
         ),
         home: BaseScreen(),
        routes: {
          AppRoutes.SignUpScreen: (context) => SignUpScreen(),
          AppRoutes.LoginScreen: (context) => LoginScreen(),
          AppRoutes.MedicineScreen: (context) => MedicineScreen(),
          AppRoutes.RegisterScreen: (context) => RegisterScreen(),
        },
       ),
    );
  }
}
