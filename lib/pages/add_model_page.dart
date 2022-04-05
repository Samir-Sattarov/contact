import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/cubit/database/database_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddModelPage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => AddModelPage());

  AddModelPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Model'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Form(
            key: _key,
            autovalidateMode: AutovalidateMode.always,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                children: [
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Enter Name';
                      }
                      return null;
                    },
                    controller: _controllerName,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blue.shade500,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.blue.shade400, width: 3),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter(
                        RegExp(r'^[+\d(\d)\d -]{1,17}$'),
                        allow: true,
                      ),
                    ],
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'Enter phone like +###(##)###-##-##';
                      }
                      return null;
                    }),
                    controller: _controllerPhone,
                    decoration: InputDecoration(
                      hintText: 'Phone',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blue.shade500,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.blue.shade400, width: 3),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_key.currentState!.validate() == true) {
            _onFloationButtonPresed(context);
          }
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.check),
      ),
    );
  }

  _onFloationButtonPresed(context) {
    BlocProvider.of<DatabaseCubit>(context).add(
      _controllerName.text,
      _controllerPhone.text,
    );
    return Navigator.pop(context, true);
  }
}
