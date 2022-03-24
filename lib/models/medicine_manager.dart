import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/models/medicine.dart';


class MedicineManager extends ChangeNotifier {

  MedicineManager(){
  _loadAllMedicine();
  }

  final Firestore firestore = Firestore.instance;

  List<Medicine> allMedicine = [];


  String _search = '';

  String get search => _search;
  set search(String value){
    _search = value;
    notifyListeners();
  }

  List<Medicine> get filteredMedicine {
    final List<Medicine> filteredMedicine = [];

    if(search.isEmpty){
      filteredMedicine.addAll(allMedicine);
    } else {
      filteredMedicine.addAll(
          allMedicine.where(
                  (p) => p.name.toLowerCase().contains(search.toLowerCase())
          )
      );
    }

    return filteredMedicine;
  }


  Future<void> _loadAllMedicine() async {
  final QuerySnapshot snapMedicine =
  await firestore.collection('medicine').getDocuments();

  allMedicine = snapMedicine.documents.map(
          (d) => Medicine.fromDocument(d)).toList();

  notifyListeners();

  }

  void update(Medicine medicine){
    allMedicine.removeWhere((m) => m.id == medicine.id);
    allMedicine.add(medicine);
    notifyListeners();
  }


}