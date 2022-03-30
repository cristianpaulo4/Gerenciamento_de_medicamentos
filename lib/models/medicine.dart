import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Medicine extends ChangeNotifier {

  Medicine({this.id, this.name, this.type, this.images}){
    images = images ?? [];
  }

  Medicine.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document['name'] as String;
    type = document['type'] as String;
    images = List<String>.from(document.data['images'] as List<dynamic>);
  }


  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.document('medicine/$id');
  StorageReference get storageRef => storage.ref().child('medicines').child(id);

  String id;
  String name;
  String type;
  List<String> images;

  List<dynamic> newImages;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners;
  }




  Future<void> save() async {
    loading = true;
    final Map<String, dynamic> data = {
      'id':id,
      'name': name,
      'type': type
    };
    
    if(id == null){
      final doc = await firestore.collection('medicine').add(data);
      id = doc.documentID;
    }else{
      await firestoreRef.updateData(data);
    }

    final List<String> updateImages = [];

    for(final newImage in newImages){
      if(images.contains(newImage)){
        updateImages.add(newImage as String);
      }else{
        final StorageUploadTask task = storageRef.child(Uuid().v1()).putFile(newImage as File);
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL() as String;
        updateImages.add(url);
      }
    }

    for(final image in images){
      if(!newImages.contains(image)){
        try {
          final ref = await storage.getReferenceFromUrl(image);
          await ref.delete();
        } catch(e){
          debugPrint('Falha ao deletar $image');
        }
      }
     }

    await firestoreRef.updateData({'images': updateImages});
    images = updateImages;

    loading = false;

  }


  void delete(){
    firestoreRef.delete();
  }


  Medicine clone(){
    return Medicine(
      id:id,
      name: name,
      type: type,
      images: List.from(images)
    );
  }

  @override
  String toString() {
    return 'Medicine{id: $id, name: $name, type: $type, images: $images, newImages: $newImages}';
  }
}