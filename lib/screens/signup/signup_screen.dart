import 'package:capstone_project/screens/signup/signup_content.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/signUp";

  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignUpContent()
      );
  }
}