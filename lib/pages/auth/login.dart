import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/auth/registation.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/widget/textFormField_widget.dart';
import 'package:flutter_application_1/widget/button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final TextEditingController _controllerLogin = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff274472),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 4.5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                ),
              ),
            ),
            Form(
              key: _globalKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormFieldWidget(
                    validator: (value) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value ?? '');

                      if (value == null || value.isEmpty || !emailValid) {
                        return 'Введите электронную почту';
                      }
                      return null;
                    },
                    prefixIcon: const Icon(Icons.email),
                    hintText: 'Email',
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.yellow.shade700,
                        width: 3,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.yellow.shade700,
                        width: 3,
                      ),
                    ),
                    errorStyle: const TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    controller: _controllerLogin,
                    focusBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue.shade100,
                        width: 3,
                      ),
                    ),
                    borderDefault: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormFieldWidget(
                    validator: (value) {
                      if (value == null && value!.isEmpty) {
                        return 'Введите пароль';
                      } else if (value.length < 8) {
                        return 'Введите больше символов';
                      } else {
                        return null;
                      }
                    },
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.yellow.shade700,
                        width: 3,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.yellow.shade700,
                        width: 3,
                      ),
                    ),
                    errorStyle: const TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Password',
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    controller: _controllerPassword,
                    focusBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue.shade100,
                        width: 3,
                      ),
                    ),
                    borderDefault: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            ButtonWidget(
              text: 'Confirm',
              onTap: () {
                if (_globalKey.currentState!.validate()) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    HomePage.route(),
                    (route) => false,
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                dev.log('login with google');
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    SvgPicture.asset('assets/images/google_logo.svg'),
                    const SizedBox(width: 10),
                    const Text(
                      'Login with google',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                dev.log('login with facebook');
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    SvgPicture.asset('assets/images/facebook_logo.svg'),
                    const SizedBox(width: 10),
                    const Text(
                      'Login with google',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.push(context, Registration.route()),
              child: const Text(
                'Registation',
                style: TextStyle(color: Colors.white60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
