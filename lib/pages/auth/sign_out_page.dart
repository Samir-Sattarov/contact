import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/auth/sign_In_page.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/widget/button.dart';

class SignOutPage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => SignOutPage());

  SignOutPage({Key? key}) : super(key: key);
  final AuthServices _auth = AuthServices();

  final userEmail = FirebaseAuth.instance.currentUser?.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Out"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Signed in as',
          ),
          const SizedBox(height: 10),
          Text(
            userEmail ?? 'Email not found',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          // button sign out
          const SizedBox(height: 10),
          ButtonWidget(
            color: Colors.blueGrey,
            shadowColor: Colors.grey,
            onTap: () async {
              await _auth.singOut();
              Navigator.of(context).pushAndRemoveUntil(
                SignInPage.route(),
                (route) => false,
              );
            },
            text: 'Sign out',
            textStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
