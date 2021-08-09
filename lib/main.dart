// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mu_blogs/Locator.dart';
import 'package:mu_blogs/Screens/Authentication/Login.dart';
import 'package:mu_blogs/Screens/LayoutTemplate.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MU BLOGS',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white,
          )),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
