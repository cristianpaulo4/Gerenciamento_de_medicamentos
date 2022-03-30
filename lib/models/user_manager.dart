import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerenciamento_medicamentos/helpers/firebase_erros.dart';
import 'package:gerenciamento_medicamentos/models/user.dart';


class UserManager with ChangeNotifier {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;



  bool _loading = false;
  bool get loading => _loading;


  Future<void> signIn({UserApp userApp, Function onFail, Function onSuccess})
   async {

    loading = true;

    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
         email: userApp.email, password: userApp.password);

      onSuccess();

    } on PlatformException catch(e){
      print(getErrorString(e.code));
      onFail(getErrorString(e.code));
   }
   loading = false;
  }


  Future<void> signUp({ UserApp userApp, Function onFail, Function onSuccess}) async {

    loading = true;

    try {
      final AuthResult result = await auth.createUserWithEmailAndPassword(
          email: userApp.email, password: userApp.password);
      userApp.id = result.user.uid;

      await userApp.saveData();

      onSuccess();

    } on PlatformException catch(e) {
      print(getErrorString(e.code));
      onFail(getErrorString(e.code));
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


  void recoverPass(String email) async {
    auth.sendPasswordResetEmail(email: email);
  }
     
}

