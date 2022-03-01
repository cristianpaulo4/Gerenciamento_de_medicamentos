import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/helpers/validators.dart';
import 'package:gerenciamento_medicamentos/models/user.dart';
import 'package:gerenciamento_medicamentos/models/user_manager.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
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
                       if(!emailValid(email!)) {
                          emailValid(email);
                        }
                       return null;
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
                          if(formKey.currentState!.validate()) {
                            userManager.signIn(
                                userApp: UserApp(
                                    email: emailController.text,
                                    password: passController.text
                                ),

                                onFail: (e){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                        content: Text(e,
                                          style: TextStyle(
                                            fontSize: 22,
                                          ) ,
                                        ))
                                  );
                                },

                                onSuccess: (){
                                  print('#######################');
                                  print('Sucesso');
                                  print('#######################');
                                  //TODO: FECHAR TELA DE LOGIN
                                }
                            );
                          }
                        },

                        child: userManager.loading ?
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
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
