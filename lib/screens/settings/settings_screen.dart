import 'package:capstone_project/screens/settings/settings_content.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName = "/login";

  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SettingsContent());
  }
}
