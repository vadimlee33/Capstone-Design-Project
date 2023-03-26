import 'package:capstone_project/screens/login/login_screen.dart';
import 'package:flutter/widgets.dart';

// We use named routes.
// All our routes will be available here.
final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => const LoginScreen()
};