import 'package:capstone_project/functions/auth.dart';
import 'package:capstone_project/screens/bot_screen/messages.dart';
import 'package:capstone_project/styles/colors.dart';
import 'package:d_chart/d_chart.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';
import '../../globals.dart/global.dart';

class BotContent extends StatefulWidget {
  const BotContent({super.key});

  @override
  State createState() => _BotContentState();
}

class _BotContentState extends State<BotContent> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
                child: Center(
              child: Column(
                children: [
                  Expanded(child: MessagesScreen(messages: messages)),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            sendMessage(_controller.text);
                            _controller.clear();
                          },
                          icon: Icon(Icons.send),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ))));
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) {
        return;
      }
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
