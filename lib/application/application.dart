import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/database/database_cubit.dart';
import 'package:flutter_application_1/cubit/network/network_cubit.dart';
import 'package:flutter_application_1/db/local_database.dart';
import 'package:flutter_application_1/pages/auth/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    const ConnectivityResult _connectionStatus = ConnectivityResult.none;
    final Connectivity _connectivity = Connectivity();
    NetworkCubit networkCubit = NetworkCubit(
      _connectionStatus,
      _connectivity,
    );

    DatabaseCubit contactCubit = DatabaseCubit(
      LocalDatabase(),
      networkCubit,
    )..getAll();

    return MultiBlocProvider(
      providers: [
        BlocProvider<DatabaseCubit>(
          create: (BuildContext context) => contactCubit,
        ),
        BlocProvider<NetworkCubit>(
          create: (BuildContext context) => networkCubit,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: Login(),
      ),
    );
  }
}
