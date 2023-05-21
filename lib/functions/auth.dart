import 'package:firebase_auth/firebase_auth.dart';

import '../globals.dart/global.dart';

class AuthenticationModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  Future signUp(
      {required String email,
      required String password,
      required String username}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      registerUserInFirestore(_auth.currentUser!.uid, username, email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      userID = _auth.currentUser!.uid;
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signOut() async {
    await _auth.signOut();
    print('signed out');
  }
}
