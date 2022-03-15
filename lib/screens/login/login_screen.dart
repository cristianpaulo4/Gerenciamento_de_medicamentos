import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/colors.dart';
import 'package:gerenciamento_medicamentos/helpers/validators.dart';
import 'package:gerenciamento_medicamentos/models/user.dart';
import 'package:gerenciamento_medicamentos/models/user_manager.dart';
import 'package:gerenciamento_medicamentos/screens/medicine/medicine_screen.dart';
import 'package:gerenciamento_medicamentos/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
      //  title: const Text('Entrar'),
      //  centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 18, 30, 0),
              child: Container(
                  child: const Text('CRIAR CONTA',
                  style: TextStyle(fontSize: 20),),
              ),
            ),
            onTap: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            },
          ),
        ],

      ),

      body: Consumer<UserManager>(
        builder: ( _, userManager, __ ){
          return Center(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      controller: emailController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                         return emailValid(email);
                      },
                    ),

                    const SizedBox(height: 16,),

                    TextFormField(
                        controller: passController,
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(hintText: 'Senha'),
                        autocorrect: false,
                        obscureText: true,
                        validator: (pass) {
                          return passValid(pass);
                        }
                    ),

                    const SizedBox(height: 16,),

                    Container(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          child: const Text(
                              'Esqueci minha senha'
                          ),
                          onTap: () {
                            print('funcionu');
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 16,),

                    SizedBox(
                      height: 44,
                      child: ElevatedButton(

                        onPressed: userManager.loading? null : () {
                          if(formKey.currentState.validate()) {
                            userManager.signIn(
                                userApp: UserApp(
                                    email: emailController.text,
                                    password: passController.text,
                                    confirmPassword: '',
                                    name: '',
                                    id: ''
                                ),

                                onFail: (e){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: ColorsApp.red,
                                        content: Text('Falha: $e',
                                          style: const TextStyle(fontSize: 22,
                                          ) ,
                                        ))
                                  );
                                },

                                onSuccess: (){

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MedicineScreen()));

                                  print('#######################');
                                  print('Sucesso');
                                  print('#######################');
                                }
                            );
                          }
                        },

                        child: userManager.loading ?
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(ColorsApp.white),
                        ):
                          const Text(
                          'Entrar',
                          style: TextStyle(
                              fontSize: 20
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),

    );
  }
}
