import 'package:capstone_project/screens/add/add_content.dart';
import 'package:capstone_project/screens/login/login_content.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  static String routeName = "/add";

  const AddScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AddContent());
  }
}
