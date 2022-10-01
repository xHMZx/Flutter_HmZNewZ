import 'package:flutter/material.dart';
import 'package:untitled/screens/homescreen.dart';
import 'package:untitled/screens/login.dart';
import 'package:untitled/screens/signup.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HMZ Newz",

      debugShowCheckedModeBanner: false,
        home: LoginScreen(

        )
    );
  }
}
