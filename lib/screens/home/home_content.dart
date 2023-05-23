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
                                      Text(_getDiaryEntryForDay(_focusedDay)),
                                      Text(
                                          'Emotion: ${_getEmotionForDay(_focusedDay)}')
                                    ]),
                                  ),
                                ),
                              ))
                        ])))));
  }
}
