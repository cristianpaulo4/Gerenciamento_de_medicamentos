import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine {

  Medicine.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document['name'] as String;
    type = document['type'] as String;
    images = List<String>.from(document.data['images'] as List<dynamic>);
  }

  String id;
  String name;
  String type;
  List<String> images;

}