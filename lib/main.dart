import 'package:capstone_project/screens/login/login_screen.dart';
import 'package:capstone_project/styles/colors.dart';
import 'package:capstone_project/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFFA98467,
          <int, Color>{
            50: Color(0xFFA98467),
            100: Color(0xFFA98467),
            200: Color(0xFFA98467),
            300: Color(0xFFA98467),
            400: Color(0xFFA98467),
            500: Color(0xFFA98467),
            600: Color(0xFFA98467),
            700: Color(0xFFA98467),
            800: Color(0xFFA98467),
            900: Color(0xFFA98467),
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Capstone Project',
      initialRoute: LoginScreen.routeName,
      routes: routes,
    );
  }
}
