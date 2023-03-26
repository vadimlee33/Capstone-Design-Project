import 'package:capstone_project/screens/login/login_screen.dart';
import 'package:capstone_project/utils/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Capstone Project',
      initialRoute: LoginScreen.routeName,
      routes: routes,
    );
  }
}