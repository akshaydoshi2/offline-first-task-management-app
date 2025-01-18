import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tushop_assesment/src/pages/home/home_screen.dart';

import 'auth/login_screen.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, AsyncSnapshot<User?> snapshot){
        if(snapshot.data == null) return const LoginScreen();
        return const HomeScreen();
      }
    );
  }
}
