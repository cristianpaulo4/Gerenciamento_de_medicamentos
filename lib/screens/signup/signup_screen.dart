import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/themes/app_colors.dart';
import 'package:gerenciamento_medicamentos/helpers/validators.dart';
import 'package:gerenciamento_medicamentos/models/user.dart';
import 'package:gerenciamento_medicamentos/models/user_manager.dart';
import 'package:gerenciamento_medicamentos/screens/medicine/medicine_screen.dart';
import 'package:gerenciamento_medicamentos/themes/app_text_styles.dart';
import 'package:provider/src/provider.dart';
import 'package:gerenciamento_medicamentos/themes/app_text_styles.dart';

class SignUpScreen extends StatelessWidget {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final UserApp userApp = UserApp(id: '', name:'' , email: '', password: '', confirmPassword: '', );

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('CADASTRO',
            style: TextStyles.titleAppBar,),
          centerTitle: true,
        ),
        body: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: <Widget>[

                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Nome Completo'),
                    validator: (name){
                      return nameValid(name) ;
                    },
                    onSaved: (name) => userApp.name = name,
                  ),

                  const SizedBox(height: 16,),

                  TextFormField(
                    decoration: const InputDecoration(hintText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email){
                      return emailValid(email);
                    },
                    onSaved: (email) => userApp.email = email,
                  ),

                  const SizedBox(height: 16,),

                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Senha'),
                    obscureText: true,
                    validator: (pass){
                      return passValid(pass);
                    },
                    onSaved: (password) => userApp.password = password,
                  ),

                  const SizedBox(height: 16,),

                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Repita a Senha'),
                    obscureText: true,
                    validator: (pass){
                      return passValid(pass);
                    },
                    onSaved: (confirmPassword) => userApp.confirmPassword = confirmPassword,
                  ),

                  const SizedBox(height: 16,),

                  ElevatedButton(
                    onPressed: (){
                     if (formKey.currentState.validate()) {
                       formKey.currentState.save();

                       if (userApp.password != userApp.confirmPassword) {
                         ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(
                                 backgroundColor: ColorsApp.RED,
                                 content: Text('Senhas não coincidem!',
                                   style: TextStyle(
                                     fontSize: 22,
                                   ),
                                 )));
                       }

                     context.read<UserManager>().signUp(
                         userApp: userApp,
                         onFail: (e){
                           ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                   backgroundColor: ColorsApp.RED,
                                   content: Text('Falha: $e',
                                     style: const TextStyle(fontSize: 22,
                                     ) ,
                                   ))
                           );
                         },

                         onSuccess: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => MedicineScreen()));
                         }
                     );
                    }},

                    child: Text('Criar conta',
                      style: TextStyles.letterBoot,
                    ),

                  ),

                ],
              ),
            ),
          ),
        ),
      );
    }
  }
