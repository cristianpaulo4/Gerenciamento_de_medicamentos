import 'package:cloud_firestore/cloud_firestore.dart';

class UserApp {

  UserApp({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword
  });


  String id;
  String name;
  String email;
  String password;
  String confirmPassword;


  DocumentReference get firestoreRef =>
    FirebaseFirestore.instance.doc('users/$id');

  Future<void> saveData() async{
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap(){
    return{
      'name': name,
      'email': email,
    };
  }

}

