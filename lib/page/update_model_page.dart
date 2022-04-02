import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/bloc/contact/contact_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateModelPage extends StatefulWidget {
  static route(updateName, updatePhone, id) => MaterialPageRoute<bool>(
        builder: (context) => UpdateModelPage(
          updateName: updateName,
          updatePhone: updatePhone,
          id: id,
        ),
      );
  final String updateName;
  final String updatePhone;
  final id;
  const UpdateModelPage({
    Key? key,
    required this.updateName,
    required this.updatePhone,
    required this.id,
  }) : super(key: key);

  @override
  State<UpdateModelPage> createState() => _UpdateModelPageState();
}

class _UpdateModelPageState extends State<UpdateModelPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();

  @override
  void initState() {
    _controllerName.text = widget.updateName;
    _controllerPhone.text = widget.updatePhone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Model'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_key.currentState!.validate() == true) {
            _onFloationActionButtonPress(context);
          }
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.check),
      ),
    );
  }

  void _onFloationActionButtonPress(BuildContext context) {
    BlocProvider.of<ContactCubit>(context).update(
      widget.id,
      _controllerName.text,
      _controllerPhone.text,
    );

    return Navigator.pop(context, true);
  }
}
