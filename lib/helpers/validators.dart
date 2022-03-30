import 'package:flutter/material.dart';

bool emailError(String email){
  final RegExp regex = RegExp(
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
  return regex.hasMatch(email);
}

String emailValid (email){
  if(email.isEmpty) {
    return 'Campo obrigatório';
  }else if (!emailError(email)) {
    return 'Email invalido';
  }
    return null;
}


String nameValid (name){
  if(name.isEmpty) {
    return 'Campo obrigatório';
  }else if (name.trim().split(' ').length < 1) {
    return 'Preencha seu Nome completo';
  }
    return null;
}


passValid(pass){
  if(pass.isEmpty) {
    return 'Campo obrigatório';
  }else if (pass.length < 6 ) {
    return 'Minimo de 6 caracteres ';
  }
  return null;
}

DescValid(description){
  if(description.length > 151) {
    return 'Descrição muito longo, Maximo 150 caracteres.';
  }
  return null;
}

nameMedicineValid(name){
  if(name.length < 1) {
    return 'Insira o nome';
  }else if(name.length > 18){
    return 'Nome muito logo, Maximo 18 caracteres';
  }
  return null;
}










