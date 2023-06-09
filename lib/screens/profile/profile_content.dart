import 'package:capstone_project/functions/auth.dart';
import 'package:capstone_project/styles/colors.dart';
import 'package:d_chart/d_chart.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';
import '../../globals.dart/global.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Rebuild the widgets here
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    final _today = DateTime.now();
    final _lastMonth = DateTime(_today.year, _today.month - 1, _today.day);

    final _formattedStartDate = DateFormat('yyyy.MM.dd').format(_lastMonth);
    final _formattedEndDate = DateFormat('yyyy.MM.dd').format(_today);

    final _dateRange =
        'Last month pie chart ($_formattedStartDate - $_formattedEndDate)';
    final emotionCount = countEmotions(diaryEntries);
    emotionCount.forEach((emotion, count) {
      print('$emotion: $count');
    });
    final pieChartData = emotionCount.entries.map((entry) {
      final emotion = entry.key;
      final count = entry.value;
      return {'domain': emotion, 'measure': count};
    }).toList();

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
                        ),
                        const SizedBox(height: 30),
                        Text(_dateRange,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
               
                        Expanded(
                            child: DChartPie(
                          data: pieChartData,
                          pieLabel: (pieChartData, index) =>
                              pieChartData['domain'],
                          fillColor: (pieChartData, index) =>
                              emotionColors[pieChartData['domain']],
                        )),
                      ]),
                    )))));
  }
}
