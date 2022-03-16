import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/db/database.dart';
import 'package:flutter_application_1/model/list_tile_model.dart';

class AddModelPage extends StatelessWidget {
  static route(memoDb) => MaterialPageRoute(
        builder: (context) => AddModelPage(
          memoDb: memoDb,
        ),
      );

  final ContactDataBaseProvider memoDb;
  AddModelPage({Key? key, required this.memoDb}) : super(key: key);
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();

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
        onPressed: () async {
          if (_key.currentState!.validate() == true) {
            await memoDb.addItem(
              ListTileModel(
                title: _controllerName.text,
                phone: _controllerPhone.text,
              ),
            );

            await memoDb.fetchMemos();
            return Navigator.pop(context, true);
          }
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.check),
      ),
    );
  }
}
