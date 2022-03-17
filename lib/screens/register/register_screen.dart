import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/common/custom_drawer/custom_drawer.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Cadastro de medicamentos'),
      ),
    );
  }
}
