import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';

class VerifiedPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const VerifiedPage());
  const VerifiedPage({Key? key}) : super(key: key);

  @override
  State<VerifiedPage> createState() => _VerifiedPageState();
}

class _VerifiedPageState extends State<VerifiedPage> {
  bool isEmailVerified = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final Timer timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = _auth.currentUser!.emailVerified;

    if (isEmailVerified == false && _auth.currentUser != null) {
      sendEmailVerification();

      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerification());
    }
  }

  checkEmailVerification() async {
    await _auth.currentUser!.reload();
    try {
      setState(() {
        isEmailVerified = _auth.currentUser!.emailVerified;
      });
    } catch (e) {
      log('message: $e');
    }
  }

  sendEmailVerification() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
    } catch (e) {
      log('message: $e');
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const HomePage()
      : Scaffold(
          appBar: AppBar(title: const Text('Email Verification')),
          backgroundColor: const Color(
            0xff363635,
          ),
          body: const Center(
            child: Text(
              'Please verify email',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
        );
}
