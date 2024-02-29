import 'package:drivers_app_project/global/global.dart';
import 'package:drivers_app_project/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({super.key});

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Sair'),
        onPressed: () {
          fAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (context) => const MySplashScreen()));
        },
      ),
    );
  }
}
