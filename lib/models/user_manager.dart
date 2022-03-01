import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/models/user.dart';

class UserManager with ChangeNotifier {

  final FirebaseAuth auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> signIn(
      {required UserApp userApp, required Function onFail, required Function onSuccess})
   async {

    loading = true;

    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
         email: userApp.email, password: userApp.password);

      onSuccess();

    } on FirebaseAuthException catch(e){
      onFail('Usuário ou senha incorreto, tente novamente');
   }
   loading = false;
  }


  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  void setLoading(bool value){
   _loading = value;
    notifyListeners();
 }

}

