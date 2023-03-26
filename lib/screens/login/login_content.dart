import 'package:capstone_project/styles/colors.dart';
import 'package:flutter/material.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [_buildMainContent()]),
        ));
  }
}

Widget _buildMainContent() {
  return Column(children: [
    Text('login'),
    Text('password')
  ]);
}