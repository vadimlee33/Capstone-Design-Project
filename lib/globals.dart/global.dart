import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

String userID = "";

late User user;

Map<String, dynamic> diaryEntries = {};

Map<String, dynamic> diaryEntriesTest = {};

bool isToday = false;

DateTime todayDate =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

String dateTimeToEpochString(DateTime dateTime) {
  int epochTime = dateTime.millisecondsSinceEpoch;
  print(epochTime.toString());
  return epochTime.toString();
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

void addNoteToDB(String userId, String note, String emotion) {
  Map<String, dynamic> documentData = {
    'id': userId,
    'note': note,
    'emotion': emotion
  };

  FirebaseFirestore.instance.collection('notes').doc(userId).set(documentData);
}
