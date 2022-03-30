import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/themes/app_colors.dart';
import 'package:gerenciamento_medicamentos/helpers/validators.dart';
import 'package:gerenciamento_medicamentos/models/user.dart';
import 'package:gerenciamento_medicamentos/models/user_manager.dart';
import 'package:gerenciamento_medicamentos/screens/medicine/medicine_screen.dart';
import 'package:gerenciamento_medicamentos/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:gerenciamento_medicamentos/themes/app_text_styles.dart';
import 'package:gerenciamento_medicamentos/models/user_manager.dart';

class LoginScreen extends StatelessWidget {


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(



      appBar: AppBar(
        actions: <Widget>[
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 18, 30, 0),
              child: Container(
                  child: Text('CRIAR CONTA',
                  style: TextStyles.titleAppBar),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
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
                          // ignore: void_checks
                          onTap: () {

                                    if(emailController.text.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: ColorsApp.RED,
                                            content: Text('Insira seu E-mail para recuperação',
                                                style: TextStyles.titleSize2),
                                            duration: const Duration(seconds: 4),
                                          )
                                      );
                                    }else if(emailValid(emailController.text)!= null){
                                      return
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: ColorsApp.RED,
                                            content: Text( emailValid(emailController.text),
                                            style: TextStyles.titleSize2,
                                             ))
                                            );
                                    }else{
                                      UserManager().recoverPass(emailController.text);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: ColorsApp.BLUE,
                                            content: Text('Confira seu E-mail',
                                                style: TextStyles.titleSize2),
                                            duration: const Duration(seconds: 4),
                                          )
                                      );
                                    }
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 16,),

                    Column(
                      children: [
                        SizedBox(
                          height: 44,
                          width: 300,
                          child: ElevatedButton(
                            onPressed: userManager.loading? null : () {
                              if(formKey.currentState.validate()) {
                                userManager.signIn(
                                    userApp: UserApp(
                                        email: emailController.text,
                                        password: passController.text,

                                    ),

                                    onFail: (e){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          backgroundColor: ColorsApp.RED,
                                            content: Text('Falha: $e',
                                              style: TextStyles.titleSize2,
                                            ))
                                      );
                                    },

                                    onSuccess: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MedicineScreen()));
                                    }
                                );
                              }
                            },

                            child: userManager.loading ?
                            const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(ColorsApp.WHITE),
                            ):
                               Text(
                              'Entrar',
                            style: TextStyles.letterBoot,
                            ),
                          ),
                        ),


                      ],
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

