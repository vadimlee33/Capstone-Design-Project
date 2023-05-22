import 'package:capstone_project/functions/auth.dart';
import 'package:capstone_project/styles/colors.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../../globals.dart/global.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 30),
                    child: Center(
                      child: Column(children: [
                        Row(
                          children: [
                            Image.asset('assets/images/profile_icon.jpg',
                                width: 80, height: 80, color: Colors.black),
                            const SizedBox(width: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Username: ${user.username}'),
                                const SizedBox(height: 5),
                                Text('E-mail: ${user.email}')
                              ],
                            )
                          ],
                        )
                      ]),
                    )))));
  }
}
