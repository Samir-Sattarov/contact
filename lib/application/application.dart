import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/contact/contact_cubit.dart';
import 'package:flutter_application_1/bloc/network/network_cubit.dart';
import 'package:flutter_application_1/bloc/snackbar/snackbar_cubit.dart';
import 'package:flutter_application_1/db/local_contact_repository.dart';
import 'package:flutter_application_1/page/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    const ConnectivityResult _connectionStatus = ConnectivityResult.none;
    final Connectivity _connectivity = Connectivity();
    NetworkCubit networkCubit = NetworkCubit(_connectionStatus, _connectivity);

    ContactCubit contactCubit =
        ContactCubit(LocalContactRepository(), networkCubit)..getAll();
    SnackBarCubit snackBarCubit = SnackBarCubit(networkCubit);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContactCubit>(
          create: (BuildContext context) => contactCubit,
        ),
        BlocProvider<NetworkCubit>(
          create: (BuildContext context) => networkCubit,
        ),
        BlocProvider<SnackBarCubit>(
          create: (BuildContext context) => snackBarCubit,
        ),
      ],
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
