import 'dart:io';

import 'package:capstone_project/functions/auth.dart';
import 'package:capstone_project/styles/colors.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:face_camera/face_camera.dart';
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
        body: SmartFaceCamera(
      showFlashControl: false,
      enableAudio: false,
      autoCapture: true,
      defaultCameraLens: CameraLens.front,
      message: 'Center your face in the square',
      onCapture: (File? image) {},
    ));
  }
}
