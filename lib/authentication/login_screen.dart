import 'package:drivers_app_project/authentication/signup_screen.dart';
import 'package:drivers_app_project/main_screens/main_screens.dart';
import 'package:drivers_app_project/splash_screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../widgets/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm() {
    if (!emailTextEditingController.text.contains('@')) {
      Fluttertoast.showToast(msg: 'O endereço de email não é válido.');
    } else if (passwordTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'a senha é obrigatória!. ');
    } else {
      loginDriverNow();
    }
  }

  loginDriverNow() async {
    //  é exibido um diálogo de progresso (ProgressDialog) para indicar que o processo de login está em andamento.
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: 'Processando, por favor aguarde...',
          );
        });
    // Em seguida, é feito o login do usuário utilizando a função signInWithEmailAndPassword() do Firebase Authentication (fAuth),
    // passando o email e a senha fornecidos pelo motorista. O resultado dessa operação é um objeto User? que representa o usuário logado.
    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text.trim(),
                password: passwordTextEditingController.text.trim())
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Erro: ${msg.toString()}');
    }))
        .user;

    // Se o firebaseUser for diferente de null, significa que o login foi bem-sucedido e o código avança para a próxima etapa.

    if (firebaseUser != null) {
      //É criada uma referência (driversRef) para o nó "drivers" no Realtime Database do Firebase.
      // Essa referência é usada para acessar informações específicas do motorista no banco de dados.

      DatabaseReference driversRef =
          FirebaseDatabase.instance.ref().child('drivers');

      //É feita uma consulta (once()) no nó "drivers" usando o UID do usuário atualmente logado.
      // A resposta da consulta é capturada na variável driverKey.

      driversRef.child(firebaseUser.uid).once().then((driverKey) {
        // A variável snap recebe o instantâneo (snapshot) dos dados retornados pela consulta.
        // Se o valor retornado não for nulo, significa que há um registro correspondente ao motorista no banco de dados.

        final snap = driverKey.snapshot;

        if (snap.value != null) {
          //Se houver um registro, o objeto firebaseUser é armazenado na variável currentFirebaseUser,
          // uma mensagem de sucesso é exibida usando o Fluttertoast e a navegação é redirecionada para a tela MySplashScreen.
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: 'Logado com sucesso!');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MySplashScreen()));
        } else {
          //Caso contrário, se não houver um registro correspondente,
          // uma mensagem informando que não há registros com o email fornecido é exibida usando o Fluttertoast.
          // Em seguida, é feito o logout (signOut()) do usuário atual e a navegação é redirecionada para a tela MySplashScreen.
          Fluttertoast.showToast(msg: 'Não há nenhum registro com este email.');
          fAuth.signOut();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MySplashScreen()));
        }
      });
    } else {
      //  Se o firebaseUser for null, isso significa que ocorreu um erro durante o login.
      //  O diálogo de progresso é fechado e uma mensagem de erro é exibida usando o Fluttertoast.
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg:
              'Ocorreu algum erro durante o login. Por favor, tente novamente.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('images/logo1.png'),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Login',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Email',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 10)),
              ),
              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                    labelText: 'Senha',
                    hintText: 'Senha',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 10)),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    validateForm();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreenAccent),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  child: Text(
                    'Ainda não possui uma conta? Entre aqui',
                    style: TextStyle(color: Colors.grey),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
