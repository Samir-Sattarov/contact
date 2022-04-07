import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/pages/auth/registation.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/widget/textFormField_widget.dart';
import 'package:flutter_application_1/widget/button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SingIn extends StatelessWidget {
  SingIn({Key? key}) : super(key: key);
  final TextEditingController _controllerLogin = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 4),
              const Text(
                'Sing In',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Do not have a account?'),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () => Navigator.push(context, Registration.route()),
                    child: const Text(
                      'Registration',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
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
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(value ?? '');

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
                          color: Colors.blue.shade700,
                          width: 3,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue.shade700,
                          width: 3,
                        ),
                      ),
                      errorStyle: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
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
                          color: Colors.blue.shade700,
                          width: 3,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue.shade700,
                          width: 3,
                        ),
                      ),
                      errorStyle: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Password',
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
                padding: EdgeInsets.zero,
                color: const Color(0xff78a2d2),
                shadowColor: const Color.fromARGB(255, 81, 127, 180),
                borderRadius: BorderRadius.circular(10),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                text: 'Confirm',
                onTap: () async {
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
              Center(
                child: GestureDetector(
                  onTap: () async {
                    UserModel result = await _authServices.singInAnonymous();
                    if (result == null) {
                      dev.log('error singIn');
                    } else {
                      dev.log('singned in ');
                      dev.log(result.uid.toString());

                      Navigator.pushAndRemoveUntil(
                        context,
                        HomePage.route(),
                        (route) => false,
                      );
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 40,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          offset: const Offset(0, 1),
                          blurRadius: 3,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: const [
                        Spacer(),
                        Icon(Icons.person),
                        SizedBox(width: 10),
                        Text(
                          'SingIn anonymously',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: () {
                    dev.log('SingIn with google');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 40,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          offset: const Offset(0, 1),
                          blurRadius: 3,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        const Spacer(),
                        SvgPicture.asset('assets/images/google_logo.svg'),
                        const SizedBox(width: 10),
                        const Text(
                          'SingIn with google',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: () {
                    dev.log(
                      'SingIn with facebook',
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 40,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          offset: const Offset(0, 1),
                          blurRadius: 3,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        const Spacer(),
                        SvgPicture.asset('assets/images/facebook_logo.svg'),
                        const SizedBox(width: 5),
                        const Text(
                          'SingIn with google',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
