import 'package:capstone_project/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AutofillGroup(
            child: Column(
              children: [
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: kWhiteColor,
                          alignment: Alignment.center,
                          child: Text(
                            'Register',
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
                              width: 150,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                'Login',
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
        ])));
  }
}
