import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

String userID = "";

late User user;

Map<int, Map<String, dynamic>> diaryEntries = {
  1682985600000: {
    "text": "Today I went for a walk in the park...",
    "emotion": "Neutral",
  },
  1683763200000: {
    "text": "Had a great time at the beach with friends!",
    "emotion": "Happy",
  },
  1684281600000: {
    "text": "Went to the movies and watched a great film...",
    "emotion": "Excited",
  },
};

Map<String, Map<String, dynamic>> diaryEntriesTest = {
  "1682985600000": {
    "text": "Today I went for a walk in the park...",
    "emotion": "Neutral",
  },
  "1683763200000": {
    "text": "Had a great time at the beach with friends!",
    "emotion": "Happy",
  },
  "1684281600000": {
    "text": "Went to the movies and watched a great film...",
    "emotion": "Excited",
  },
};

bool isToday = false;

DateTime todayDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);


int dateTimeToEpochString(DateTime dateTime) {
  int epochTime = dateTime.millisecondsSinceEpoch;
  print(epochTime.toString());
  return epochTime;
}

void registerUserInFirestore(String id, String username, String email) {
  Map<int, Map<String, dynamic>> diaries = {};
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
      String username = data['username'];
      print(username);
    } else {
      print('Username not found');
    }
  } else {
    print('Document does not exist');
  }
}

void addNoteToDB(String userId, String note, String emotion) {
  Map<String, dynamic> documentData = {
    'id': userId,
    'note': note,
    'emotion': emotion
  };

  FirebaseFirestore.instance.collection('notes').doc(userId).set(documentData);
}
