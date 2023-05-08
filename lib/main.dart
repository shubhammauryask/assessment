

import 'package:assessment/homeScreen.dart';
import 'package:assessment/loginScreen.dart';
import 'package:assessment/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login' : (context) => const MyLogin(),
      'signup' : (context) => const MySignUp(),
      'home' : (context) => const MyHomeScreen()
    },
  ));
}

