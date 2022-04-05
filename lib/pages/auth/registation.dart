import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/textFormField_widget.dart';
import 'package:flutter_application_1/widget/button.dart';

class Registration extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => Registration());

  Registration({Key? key}) : super(key: key);
  final TextEditingController _controllerLogin = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
      ),
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
                'Sing up',
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
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Введите имя';
                      } else if (text.length < 2) {
                        return 'Введите верное имя';
                      }
                    },
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'Name',
                    errorBorder: OutlineInputBorder(
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
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.yellow.shade700,
                        width: 3,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    controller: _controllerName,
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
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  TextFormFieldWidget(
                    validator: (text) {
                      if (text == null && text!.isEmpty) {
                        return 'Введите пароль';
                      } else if (text.length < 8) {
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
                    errorStyle: const TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.yellow.shade700,
                        width: 3,
                      ),
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
                  log('validated');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.amber,
                      content: Text(
                        'Account added',
                        style: TextStyle(
                          color: Color(0xff274472),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
