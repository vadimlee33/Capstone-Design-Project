import 'dart:io';

import 'package:capstone_project/functions/auth.dart';
import 'package:capstone_project/styles/colors.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class AddContent extends StatefulWidget {
  const AddContent({super.key});

  @override
  State createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 30),
                child: Center(
                    child: Column(
                  children: [],
                )))),
      ),
    );
  }
}
