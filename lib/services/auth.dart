import 'dart:developer' as dev;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
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
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } catch (error) {
      dev.log('Error message: $error');
    }
  }

  Future registerWithEmailPassword(String email, String password) async {
    try {
      _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on PlatformException catch (error) {
      throw Exception(error.message);
    }
  }

  Future singOut() async {
    _auth.signOut();
  }
}
