import 'package:capstone_project/functions/auth.dart';
import 'package:capstone_project/styles/colors.dart';
import 'package:d_chart/d_chart.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
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

    final pieChartDataTest = [
      {
        'id': 'Bar',
        'data': [
          {'domain': 'love', 'measure': 1},
          {'domain': 'sadness', 'measure': 2},
          {'domain': 'fear', 'measure': 5},
          {'domain': 'joy', 'measure': 2},
          {'domain': 'surprise', 'measure': 1},
          {'domain': 'anger', 'measure': 1}
        ],
      },
    ];

    // Map<String, double> dataMap = {
    //   "love": 1,
    //   "sadness": 3,
    //   "joy": 2,
    //   "fear": 5,
    //   "surprise": 2,
    //   "angry": 1,
    // };

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
                        // Expanded(
                        //     child: PieChart(
                        //   dataMap: dataMap,
                        //   animationDuration: Duration(milliseconds: 800),
                        //   chartLegendSpacing: 32,
                        //   chartRadius: MediaQuery.of(context).size.width / 3.2,
                        //   colorList: colorList,
                        //   initialAngleInDegree: 0,
                        //   chartType: ChartType.ring,
                        //   ringStrokeWidth: 32,
                        //   centerText: "HYBRID",
                        //   legendOptions: LegendOptions(
                        //     showLegendsInRow: false,
                        //     legendPosition: LegendPosition.right,
                        //     showLegends: true,
                        //     legendTextStyle: TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        //   chartValuesOptions: ChartValuesOptions(
                        //     showChartValueBackground: true,
                        //     showChartValues: true,
                        //     showChartValuesInPercentage: false,
                        //     showChartValuesOutside: false,
                        //     decimalPlaces: 1,
                        //   ),
                        //   // gradientList: ---To add gradient colors---
                        //   // emptyColorGradient: ---Empty Color gradient---
                        // ))
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
