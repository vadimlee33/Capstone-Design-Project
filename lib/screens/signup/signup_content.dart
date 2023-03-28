import 'package:capstone_project/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            child:
                Padding(padding: const EdgeInsets.only(left: 30, right: 30), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AutofillGroup(
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  autofillHints: const [AutofillHints.username],
                  controller: _usernameController,
                  maxLines: 1,
                  decoration: const InputDecoration(labelText: 'Enter Username'),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  controller: _emailController,
                  maxLines: 1,
                  decoration: const InputDecoration(labelText: 'Enter Email'),
                ),
                TextFormField(
                  obscureText: _isShowPass,
                  autofillHints: const [AutofillHints.newPassword],
                  controller: _passwordController,
                  maxLines: 1,
                  decoration: InputDecoration(
                      labelText: 'Enter Password',
                      suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isShowPass = _isShowPass ? false : true;
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
                TextFormField(
                  obscureText: _isShowPassConfirm,
                  autofillHints: const [AutofillHints.newPassword],
                  controller: _passwordConfirmController,
                  maxLines: 1,
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isShowPassConfirm = _isShowPassConfirm ? false : true;
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
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                          color: kWhiteColor,
                          alignment: Alignment.center,
                          child: Text(
                            'Back',
                            style: TextStyle(
                                color: kBlueColor, fontWeight: FontWeight.w500),
                          ),
                        ),
                      )),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                shadowColor: MaterialStateProperty.all<Color>(
                                    Colors.transparent),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    kGreenColor),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kBlueColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ))),
                            child: Container(
                              width: 250,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                'Create account',
                                style: TextStyle(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.w500),
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
