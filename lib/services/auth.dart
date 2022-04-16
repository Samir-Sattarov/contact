import 'dart:developer' as dev;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
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

  Future registerWithEmailPassword(
      {required String email, required String password}) async {
    try {
      _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on PlatformException catch (error) {
      throw Exception(error.message);
    }
  }

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }

  Future singOut() async {
    _auth.signOut();
  }
}
