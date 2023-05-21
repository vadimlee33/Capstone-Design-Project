import 'package:capstone_project/functions/auth.dart';
import 'package:capstone_project/screens/login/login_screen.dart';
import 'package:capstone_project/styles/colors.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

TextEditingController _usernameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _passwordConfirmController = TextEditingController();
bool _isShowPass = true;
bool _isShowPassConfirm = true;

class SignUpContent extends StatefulWidget {
  const SignUpContent({super.key});

  @override
  State createState() => _SignUpContentState();
}

class _SignUpContentState extends State<SignUpContent> {
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
                              keyboardType: TextInputType.text,
                              autofillHints: const [AutofillHints.username],
                              controller: _usernameController,
                              maxLines: 1,
                              decoration: InputDecoration(
                                  labelText: 'Enter Username',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  filled: true,
                                  fillColor: kGreenColor),
                            ),
                            const SizedBox(height: 20),
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
                                  labelText: 'Enter Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  filled: true,
                                  fillColor: kGreenColor,
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
                                            color: kBlueColor,
                                          )
                                        : const Icon(
                                            CupertinoIcons.eye_solid,
                                            color: kBlueColor,
                                          ),
                                  )),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              obscureText: _isShowPassConfirm,
                              autofillHints: const [AutofillHints.newPassword],
                              controller: _passwordConfirmController,
                              maxLines: 1,
                              decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  filled: true,
                                  fillColor: kGreenColor,
                                  suffix: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isShowPassConfirm =
                                            _isShowPassConfirm ? false : true;
                                      });
                                    },
                                    child: _isShowPassConfirm
                                        ? const Icon(
                                            CupertinoIcons.eye_slash,
                                            color: kBlueColor,
                                          )
                                        : const Icon(
                                            CupertinoIcons.eye_solid,
                                            color: kBlueColor,
                                          ),
                                  )),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    duration: Duration(milliseconds: 200),
                                    type: PageTransitionType.leftToRight,
                                    child: const LoginScreen()));
                          },
                          style: ButtonStyle(
                              shadowColor:
                                  MaterialStateProperty.all<Color>(kGreenColor),
                              overlayColor:
                                  MaterialStateProperty.all<Color>(kGreenColor),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(kGreenColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ))),
                          child: Container(
                            width: 100,
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text(
                              'Back',
                              style: TextStyle(
                                  color: kBrownColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                            if (_usernameController.text == '') {
                              print('input username');
                            } else {
                              if (_emailController.text == '') {
                                ElegantNotification.error(
                                        showProgressIndicator: false,
                                        title: Text('Registration Error'),
                                        description: Text("No email"))
                                    .show(context);
                              } else {
                                if (_passwordController.text == '') {
                                  ElegantNotification.error(
                                          showProgressIndicator: false,
                                          title: Text('Registration Error'),
                                          description: Text("No Password"))
                                      .show(context);
                                } else {
                                  if (_passwordConfirmController.text == '') {
                                    ElegantNotification.error(
                                            showProgressIndicator: false,
                                            title: Text('Registration Error'),
                                            description:
                                                Text("Confirm password"))
                                        .show(context);
                                  } else {
                                    if (_passwordController.text !=
                                        _passwordConfirmController.text) {
                                      ElegantNotification.error(
                                              showProgressIndicator: false,
                                              title: Text('Registration Error'),
                                              description:
                                                  Text("Passwords do no match"))
                                          .show(context);
                                    } else {
                                      AuthenticationModel()
                                          .signUp(
                                              username:
                                                  _usernameController.text,
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text)
                                          .then((result) {
                                        if (result == null) {
                                          ElegantNotification.success(
                                                  showProgressIndicator: false,
                                                  title: const Text("Success!"),
                                                  description: Text(
                                                      'Account was succesfully created'))
                                              .show(context);
                                          _usernameController.clear();
                                          _emailController.clear();
                                          _passwordConfirmController.clear();
                                          _passwordController.clear();
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  duration: const Duration(
                                                      milliseconds: 250),
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child: const LoginScreen()));
                                        } else {
                                          ElegantNotification.error(
                                                  showProgressIndicator: false,
                                                  title: const Text(
                                                      "Registration Error"),
                                                  description: Text(result))
                                              .show(context);
                                        }
                                      });
                                    }
                                  }
                                }
                              }
                            }
                          },
                          style: ButtonStyle(
                              shadowColor:
                                  MaterialStateProperty.all<Color>(kGreenColor),
                              overlayColor:
                                  MaterialStateProperty.all<Color>(kGreenColor),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(kGreenColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ))),
                          child: Container(
                            width: 150,
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              'Create account',
                              style: TextStyle(
                                  color: kBrownColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ]))));
  }
}
