import 'package:capstone_project/functions/auth.dart';
import 'package:capstone_project/globals.dart/global.dart';
import 'package:capstone_project/styles/colors.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool hasNote = false;

  bool afterToday = false;

  //Map<DateTime, String> diaryEntries = {};

  final kFirstDay = DateTime(2021);
  final kLastDay = DateTime(2025);

  List<String> selectedSongs = [];

  TextEditingController _diaryEntryController = TextEditingController();

  String _getDiaryEntryForDay(DateTime day) {
    String epochTime = dateTimeToEpochString(day);

    if (diaryEntries.containsKey(epochTime)) {
      String text = diaryEntries[epochTime]!['text'];
      return text != null ? text : '';
    } else {
      return '';
    }
  }

  String _getEmotionForDay(DateTime day) {
    String epochTime = dateTimeToEpochString(day);

    if (diaryEntries.containsKey(epochTime)) {
      String text = diaryEntries[epochTime]!['emotion'];
      return text != null ? text : '';
    } else {
      return '';
    }
  }

  void _saveDiaryEntry() async {
    if (_diaryEntryController.text != '') {
      String epochTimeToSave = dateTimeToEpochString(_selectedDay!);
      final _result = await scoreText(_diaryEntryController.text);
      final _predictedEmotion = _result['predicted_emotion'];
      Map<String, dynamic> newEntry = {
        "text": _diaryEntryController.text,
        "emotion": _predictedEmotion,
      };

      setState(() {
        diaryEntries[epochTimeToSave] = newEntry;
        _diaryEntryController.clear();
        user.diaryEntries = diaryEntries;
        updateData();
        hasNote = true;
      });
    } else {
      // Handle the case when _diaryEntryController.text is empty
    }
  }

  void _onDaySelected(selectedDay, focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      // Call `setState()` when updating the selected day
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  void _onFormatChanged(CalendarFormat format) {
    if (_calendarFormat != format) {
      // Call `setState()` when updating calendar format
      setState(() {
        _calendarFormat = format;
      });
    }
  }

  List<String> _getDiaryEntryForCalendar(DateTime day) {
    return [diaryEntries[day]!['text'] ?? ''];
  }

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
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                              child: TableCalendar(
                            firstDay: kFirstDay,
                            lastDay: kLastDay,
                            focusedDay: _focusedDay,
                            calendarFormat: _calendarFormat,
                            calendarStyle: CalendarStyle(
                              selectedDecoration: BoxDecoration(
                                color:
                                    kGreenColor_2, // Set the selected color here
                                shape: BoxShape.circle,
                              ),
                              todayDecoration: BoxDecoration(
                                color: kBrownColor, // Set the active color here
                                shape: BoxShape.circle,
                              ),
                              selectedTextStyle: TextStyle(color: Colors.white),
                              todayTextStyle: TextStyle(color: Colors.white),
                            ),
                            selectedDayPredicate: (day) {
                              // Use `selectedDayPredicate` to determine which day is currently selected.
                              // If this returns true, then `day` will be marked as selected.

                              // Using `isSameDay` is recommended to disregard
                              // the time-part of compared DateTime objects.
                              return isSameDay(_selectedDay, day);
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              if (!isSameDay(_selectedDay, selectedDay)) {
                                setState(() {
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;
                                });

                                print(diaryEntries);

                                if (_getDiaryEntryForDay(_focusedDay) == '') {
                                  setState(() {
                                    hasNote = false;
                                  });
                                } else {
                                  setState(() {
                                    hasNote = true;
                                  });
                                }
                              }
                            },
                            onFormatChanged: (format) {
                              if (_calendarFormat != format) {
                                // Call `setState()` when updating calendar format
                                setState(() {
                                  _calendarFormat = format;
                                });
                              }
                            },
                            onPageChanged: (focusedDay) {
                              // No need to call `setState()` here
                              _focusedDay = focusedDay;
                            },
                          )),
                          SizedBox(height: 16),
                          Visibility(
                              visible: _focusedDay.isBefore(tomorrowDate) &&
                                  !hasNote,
                              child: TextField(
                                controller: _diaryEntryController,
                                decoration: InputDecoration(
                                  hintText: 'Write your diary entry here...',
                                ),
                              )),
                          Visibility(
                              visible: _focusedDay.isBefore(tomorrowDate) &&
                                  !hasNote,
                              child: ElevatedButton(
                                onPressed: _saveDiaryEntry,
                                child: Text('Save'),
                              )),
                          SizedBox(height: 16),
                          Visibility(
                              visible: _getDiaryEntryForDay(_focusedDay) != '',
                              child: Expanded(
                                child: SingleChildScrollView(
                                  child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Column(children: [
                                        const Text(
                                            "Your feelings for that day:",
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF6C584C))),
                                        const SizedBox(height: 10),
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Column(children: [
                                              Text(
                                                _getDiaryEntryForDay(
                                                    _focusedDay),
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF6C584C)),
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    EmotionWidget(
                                                        emotion:
                                                            _getEmotionForDay(
                                                                _focusedDay)),
                                                  ]),
                                              const SizedBox(height: 50),
                                              InkWell(
                                                onTap: () {
                                                  final String currentEmotion =
                                                      _getEmotionForDay(
                                                          _focusedDay);

                                                  List<String> shuffledList;

                                                  if (currentEmotion ==
                                                      'sadness') {
                                                    shuffledList = List.from(
                                                        sadnessSongsList)
                                                      ..shuffle();
                                                  } else if (currentEmotion ==
                                                      'joy') {
                                                    shuffledList =
                                                        List.from(joySongsList)
                                                          ..shuffle();
                                                  } else if (currentEmotion ==
                                                      'love') {
                                                    shuffledList =
                                                        List.from(loveSongsList)
                                                          ..shuffle();
                                                  } else if (currentEmotion ==
                                                      'anger') {
                                                    shuffledList = List.from(
                                                        angerSongsList)
                                                      ..shuffle();
                                                  } else if (currentEmotion ==
                                                      'fear') {
                                                    shuffledList =
                                                        List.from(fearSongsList)
                                                          ..shuffle();
                                                  } else {
                                                    shuffledList = List.from(
                                                        surprisedSongsList)
                                                      ..shuffle();
                                                  }

                                                  selectedSongs = shuffledList
                                                      .take(3)
                                                      .toList();

                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        content: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 30),
                                                            height: 140,
                                                            child: Column(
                                                                children: [
                                                                  Center(
                                                                      child: Text(
                                                                          shuffledList[
                                                                              0],
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style: TextStyle(
                                                                              fontFamily: 'Inter',
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Color(0xFF6C584C)))),
                                                                  const Spacer(),
                                                                  Center(
                                                                      child: Text(
                                                                          shuffledList[
                                                                              1],
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style: TextStyle(
                                                                              fontFamily: 'Inter',
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Color(0xFF6C584C)))),
                                                                  const Spacer(),
                                                                  Center(
                                                                      child: Text(
                                                                          shuffledList[
                                                                              2],
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style: TextStyle(
                                                                              fontFamily: 'Inter',
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Color(0xFF6C584C)))),
                                                                ])),
                                                        actions: [
                                                          TextButton(
                                                            child: Text('Ok'),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                    color: kBrownColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10), // Set the background color to blue
                                                  ),
                                                  child: Text(
                                                    'Get music for that day',
                                                    style: TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            ])),
                                      ])),
                                ),
                              ))
                        ])))));
  }
}

class EmotionWidget extends StatelessWidget {
  final String emotion;
  const EmotionWidget({Key? key, required this.emotion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = emotionColors[emotion.toLowerCase()] ?? Colors.blue;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(60.0)),
      child: Text(emotion,
          style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              color: Color(0xFF6C584C))),
    );
  }
}
