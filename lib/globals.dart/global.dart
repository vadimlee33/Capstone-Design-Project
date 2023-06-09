import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

const String serverIP = "10.0.2.2";

String userID = "";

late User user;

const primaryColor = Color.fromARGB(244, 85, 244, 146);

final emotionColors = {
  'sadness': Color(0xFFA9DEF9),
  'joy': Colors.yellow,
  'love': Color(0xFFFF99C8),
  'angry': Color(0xFFF08080),
  'fear': Color(0xFFD0F4DE),
  'surprise': Color(0xFFE4C1F9)
};

const List<String> sadnessSongsList = [
  'Alec Benjamin - If We Have Each Other',
  'Duncan Laurence - Arcade',
  'Måneskin - THE LONELIEST',
  'Imagine Dragons - Wrecked',
  'Hillsong United - Ocean',
  'Avril Lavigne - When you’re gone',
  'Betperde - MEREY',
  'Want it? - Zemfira',
  'Evanescence - My Immortal',
  'Markul - Fata Morgana'
];

const List<String> joySongsList = [
  'King Harvest - Dancing in The Moonlight',
  'Corinne Bailey Rae - Put Your Records On',
  'Post Malone - Sunflower',
  'Alphaville - Forever young',
  'Vance Joy - Riptide',
  'Nick Youre, dazy - Sunroof',
  'Dem - Raim',
  'Griby - Taet led',
  'Lil Skies - Nowadays',
  'Neffex - Best of Me'
];

const List<String> loveSongsList = [
  'Tyler, The Creator - ARE WE STILL FRIENDS?',
  'slchld, whoosh - still friends, not lovers',
  'Stephen Sanchez - Until I found you',
  'Harry Styles - Love of My life',
  'Taylor Swift - Love story',
  'New West - Those eyes',
  'Joji - Glimpse of Us',
  'Kina, Snow - Get You The Moon',
  'TWICE - What is Love',
  'Halsey - Bad At Love'
];

const List<String> angerSongsList = [
  'Tyler, The Creator - SORRY NOT SORRY',
  'Nirvana - Smells Like Teen Spirit',
  'Imagine Dragons - Dull Knives',
  'Oasis - Don’t look back in anger',
  'Imagine Dragons - Bad Liar',
  'Imagine Dragons- Natural',
  'Coolie, L.V. - Gangsta’s Paradise',
  'Ghostmane - Mercury:Retrograde',
  'Evanescence - Bring Me To Life',
  'Eminem - Lose Yourself'
];

const List<String> fearSongsList = [
  'Anson Seabra - Trying My Best',
  'Alley Duhé - Middle of the night',
  'Broken People - almost monday',
  'Vampire - Dominic Fike',
  'Jeremy Zucker - Scared',
  'NF - Let You Down',
  'XXXtentacion - SAD!',
  'Cigarettes after sex - Apocalypse',
  'Han Yo Han - 400km',
  'Lil Happy Lil Sad - Survive'
];

const List<String> surprisedSongsList = [
  'Bruno Mars - Treasure',
  'Mac Miller - GOOD NEWS',
  'Post Malone - Wow',
  'Alex Benjamin - Oh My God',
  'The Script - Hall of Fame',
  'Imagine Dragons - It’s time',
  'Dybbukk, Sabrina Gomes - It’s Not So Bad',
  '1nonly - Stay With Me',
  'LiSA - Unlasting',
  'Machine Gun Kelly - my ex’s best friend'
];

Map<String, dynamic> diaryEntries = {};

Map<String, dynamic> diaryEntriesTest = {};

DateTime todayDate =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

DateTime tomorrowDate =
    DateTime(todayDate.year, todayDate.month, todayDate.day + 1);

String dateTimeToEpochString(DateTime dateTime) {
  int epochTime = dateTime.millisecondsSinceEpoch;
  print(epochTime.toString());
  return epochTime.toString();
}

Map<String, int> countEmotions(Map<String, dynamic> entries) {
  final Map<String, int> emotionCount = {};

  entries.forEach((_, entry) {
    final emotion = entry['emotion'] as String?;
    if (emotion != null) {
      emotionCount[emotion] = (emotionCount[emotion] ?? 0) + 1;
    }
  });

  return emotionCount;
}

void registerUserInFirestore(String id, String username, String email) {
  Map<String, dynamic> documentData = {
    'id': id,
    'username': username,
    'email': email,
    'diaryEntries': diaryEntriesTest
  };

  FirebaseFirestore.instance.collection('users').doc(id).set(documentData);
}

void getUserData() async {
  DocumentSnapshot documentSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(userID).get();

  if (documentSnapshot.exists) {
    // Access the document data
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    if (data.containsKey('username')) {
      diaryEntries = data['diaryEntries'];
      String username = data['username'];
      user = User(
          diaryEntries: data['diaryEntries'],
          username: data['username'],
          email: data['email'],
          id: data['id']);
      print('Logged in with user: $username');
    } else {
      print('Username not found');
    }
  } else {
    print('Document does not exist');
  }
}

void updateData() {
  FirebaseFirestore.instance.collection('users').doc(userID).update({
    'diaryEntries': user.diaryEntries,
    'email': user.email,
    'id': user.id,
    'username': user.username
  }).then((_) {
    print('Document updated successfully.');
  }).catchError((error) {
    print('Failed to update document: $error');
  });
}

Future<Map<String, dynamic>> scoreText(String text) async {
  final url = Uri.parse('http://$serverIP:8000/score_text');
  final response = await http.post(
    url,
    body: json.encode({"text": text}),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data;
  } else {
    throw Exception('Failed to score text: ${response.statusCode}');
  }
}
