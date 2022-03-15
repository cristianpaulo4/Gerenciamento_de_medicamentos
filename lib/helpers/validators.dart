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



