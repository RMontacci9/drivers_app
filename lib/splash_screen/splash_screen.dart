import 'dart:async';

import 'package:drivers_app_project/authentication/login_screen.dart';
import 'package:drivers_app_project/authentication/signup_screen.dart';
import 'package:drivers_app_project/global/global.dart';
import 'package:drivers_app_project/main_screens/main_screens.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  startTimer(){
    Timer( const Duration(seconds: 3), () async{
      if(await fAuth.currentUser != null){

        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreens()));
      } else {

        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo1.png'),
          const SizedBox(height: 10,),
          const  Text('Uber & inDriver Clone App', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
