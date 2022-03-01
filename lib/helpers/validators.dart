bool emailValid(String email){
  final RegExp regex = RegExp(
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
  return regex.hasMatch(email);
}

String? passValid(pass){
  if(pass!.isEmpty) {
    return 'preencha uma senha';
  }else if (pass.length < 6 ) {
    return 'Minimo de 6 caracteres ';
  }
  return null;
}

