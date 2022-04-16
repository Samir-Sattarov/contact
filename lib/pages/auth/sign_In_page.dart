import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/network/network_cubit.dart';
import 'package:flutter_application_1/cubit/network/network_state.dart';
import 'package:flutter_application_1/pages/auth/sign_up_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/widget/textFormField_widget.dart';
import 'package:flutter_application_1/widget/button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignInPage());

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _controllerLogin = TextEditingController();

  final TextEditingController _controllerPassword = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final AuthServices _authServices = AuthServices();

  bool _activeButton = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: BlocListener<NetworkCubit, NetworkState>(
        listener: (context, state) {
          if (state is NetworkConnectedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('connected'),
                backgroundColor: Colors.green,
              ),
            );
            setState(() {
              _activeButton = true;
            });
          }
          if (state is NetworkDisconnectedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('dissconnected'),
                backgroundColor: Colors.red,
              ),
            );
            setState(() {
              _activeButton = false;
            });
          }
        },
        child: Form(
          key: _globalKey,
          autovalidateMode: AutovalidateMode.always,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Sing In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue.shade400,
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
                        onTap: () =>
                            Navigator.push(context, SignUpPage.route()),
                        child: const Text(
                          'Registration',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  Column(
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
                    onTap: _activeButton == true
                        ? () async {
                            if (_globalKey.currentState!.validate()) {
                              await _authServices.singInWithEmailPassword(
                                _controllerLogin.text,
                                _controllerPassword.text,
                              );

                              Navigator.pushAndRemoveUntil(
                                context,
                                HomePage.route(),
                                (route) => false,
                              );
                            }
                          }
                        : () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: const Center(
                                    child: Text(
                                      "Please connect to ethernet",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  content: TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      'Ok',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 10),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        final result = _authServices.googleLogin();
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
                              'Sign In with google',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
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
                          'Sign In with facebook',
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
                              'Sign In with google',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
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
        ),
      ),
    );
  }
}
