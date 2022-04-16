import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/services/auth.dart';

class VerifiedPage extends StatefulWidget {
  const VerifiedPage({Key? key}) : super(key: key);

  @override
  State<VerifiedPage> createState() => _VerifiedPageState();
  static route() =>
      MaterialPageRoute(builder: (context) => const VerifiedPage());
}

class _VerifiedPageState extends State<VerifiedPage> {
  bool isEmailVerified = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthServices _authServices = AuthServices();

  Timer timer = Timer.periodic(const Duration(seconds: 0), (timer) {});

  @override
  void initState() {
    super.initState();
    log('current user: ${_auth.currentUser != null}');
    if (_auth.currentUser != null) {
      isEmailVerified = _auth.currentUser!.emailVerified;
    }

    if (isEmailVerified == false) {
      sendVerification();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerification(),
      );
    }
  }

  Future sendVerification() async {
    await sendEmailVerification();
  }

  Future<void> sendEmailVerification() async {
    try {
      log('send email verification');
      final user = _auth.currentUser;
      await user!.sendEmailVerification();

      log('send to email ${_auth.currentUser!.email}');
    } catch (e) {
      log('error $e');
    }
  }

  checkEmailVerification() async {
    await _auth.currentUser!.reload();
    try {
      setState(() {
        isEmailVerified = _auth.currentUser!.emailVerified;
      });
      if (isEmailVerified == true) {
        log('email verified');
        timer.cancel();
      }
      log('status email verification: ${isEmailVerified.toString()}');
    } catch (e) {
      log('error $e');
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
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Please verify email',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await sendEmailVerification();
                  },
                  child: const Text('send again'),
                )
              ],
            ),
          ),
        );
}
