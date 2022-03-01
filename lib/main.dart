import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/models/user_manager.dart';
import 'package:gerenciamento_medicamentos/screens/base/base_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 // await FirebaseAuth.instance.useAuthEmulator();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserManager(),
     child: MaterialApp(
        title: 'Gerenciamento de medicamentos',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blueGrey,
          appBarTheme: const AppBarTheme(
            elevation: 0
          ),
          scaffoldBackgroundColor: Colors.blue,
        ),
        home: BaseScreen(),
      ),
    );
  }
}
