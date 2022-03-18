import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/contact/contact_cubit.dart';
import 'package:flutter_application_1/db/firebase_contact_repository.dart';
import 'package:flutter_application_1/db/local_contact_repository.dart';
import 'package:flutter_application_1/page/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContactCubit contactCubit = ContactCubit(FireBaseContactRepository())
      ..getAll();
    return BlocProvider(
      create: (context) => contactCubit,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const HomePage(),
      ),
    );
  }
}
