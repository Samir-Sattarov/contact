import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/model/user.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> _userFromFirebaseUser(User? user) async {
    return user != null ? UserModel(uid: user.uid.toString()) : null;
  }

  Future singInAnonymous() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      var user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future singInWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;
      return user;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future registerWithEmailPassword() async {}

  Future singOut() async {}
}
