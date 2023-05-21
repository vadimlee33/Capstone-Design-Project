import 'package:capstone_project/functions/auth.dart';
import 'package:capstone_project/globals.dart/global.dart';
import 'package:capstone_project/screens/home/home_screen.dart';
import 'package:capstone_project/screens/signup/signup_screen.dart';
import 'package:capstone_project/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
bool _isShowPass = true;

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
            child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutofillGroup(
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const [AutofillHints.email],
                              controller: _emailController,
                              maxLines: 1,
                              decoration: InputDecoration(
                                  labelText: 'Enter Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  filled: true,
                                  fillColor: kGreenColor),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              obscureText: _isShowPass,
                              autofillHints: const [AutofillHints.newPassword],
                              controller: _passwordController,
                              maxLines: 1,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  filled: true,
                                  fillColor: kGreenColor,
                                  labelText: 'Enter Password',
                                  suffix: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isShowPass =
                                            _isShowPass ? false : true;
                                      });
                                    },
                                    child: _isShowPass
                                        ? const Icon(
                                            CupertinoIcons.eye_slash,
                                            color: Colors.black,
                                          )
                                        : const Icon(
                                            CupertinoIcons.eye_solid,
                                            color: Colors.black,
                                          ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          // Navigator.pushNamed(
                                          //     context, SignUpScreen.routeName);
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  duration: const Duration(
                                                      milliseconds: 250),
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child: const SignUpScreen()));
                                        },
                                        style: ButtonStyle(
                                            shadowColor: MaterialStateProperty
                                                .all<Color>(kGreenColor),
                                            overlayColor: MaterialStateProperty
                                                .all<Color>(kGreenColor),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(kGreenColor),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ))),
                                        child: Container(
                                          width: 150,
                                          height: 50,
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Registration',
                                            style: TextStyle(
                                                color: kBrownColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          AuthenticationModel()
                                              .signIn(
                                                  email: _emailController.text,
                                                  password:
                                                      _passwordController.text)
                                              .then((result) {
                                            if (result == null) {
                                              getUserData();

                                              ElegantNotification.success(
                                                      showProgressIndicator:
                                                          true,
                                                      title: const Text(
                                                          "Success!"),
                                                      description:
                                                          Text('Logging in..'))
                                                  .show(context);
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      duration: const Duration(
                                                          milliseconds: 250),
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child:
                                                          const HomeScreen()));
                                            } else {
                                              ElegantNotification.error(
                                                      showProgressIndicator:
                                                          false,
                                                      title: const Text(
                                                          "Login Error"),
                                                      description: Text(result))
                                                  .show(context);
                                            }
                                          });
                                        },
                                        style: ButtonStyle(
                                            shadowColor: MaterialStateProperty
                                                .all<Color>(kGreenColor),
                                            overlayColor: MaterialStateProperty
                                                .all<Color>(kGreenColor),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(kGreenColor),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ))),
                                        child: Container(
                                          width: 150,
                                          height: 50,
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                                color: kBrownColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ]))));
  }
}
