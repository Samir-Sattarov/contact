import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/bloc/contact/contact_cubit.dart';
import 'package:flutter_application_1/model/contact_model.dart';
import 'package:flutter_application_1/page/add_model_page.dart';
import 'package:flutter_application_1/page/update_model_page.dart';
import 'package:flutter_application_1/widget/alert_dialog_widget.dart';
import 'package:flutter_application_1/widget/list_tile_widget.dart';
import 'package:flutter_application_1/widget/search_field_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String query = '';
  final ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectibityStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (error) {
      developer.log('Error message', error: error);
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectibityStatus(result);
  }

  Future<void> _updateConnectibityStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.wifi) {
      developer.log('connected to wifi');
    } else if (result == ConnectivityResult.none) {
      developer.log('no connection to WIFI ');
    } else if (result == ConnectivityResult.mobile) {
      developer.log('connected to Mobile Data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text('Contact Book Application'),
        actions: [
          IconButton(
            onPressed: () async {
              BlocProvider.of<ContactCubit>(context).getAll();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          buildSearch(),
          BlocBuilder<ContactCubit, List<ContactModel>>(
            builder: (context, contact) {
              return Expanded(
                child: ListView.builder(
                  itemCount: contact.length,
                  itemBuilder: (BuildContext context, int index) {
                    final model = contact[index];
                    return buildModel(model);
                  },
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final isAdded = await Navigator.push(context, AddModelPage.route());
          if (isAdded != null && isAdded == true) {
            BlocProvider.of<ContactCubit>(context).getAll();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search',
        onChanged: search,
      );

  void search(String query) {
    BlocProvider.of<ContactCubit>(context).search(query);
  }

  Widget buildModel(ContactModel model) => ListTileWidget(
        title: model.title,
        phone: model.phone,
        id: model.id.toString(),
        onTap: () async {
          final result = await Navigator.push<bool>(
            context,
            UpdateModelPage.route(
              model.title,
              model.phone,
              model.id,
            ),
          );
          if (result != null && result) {
            BlocProvider.of<ContactCubit>(context).getAll();
          }
        },
        onDelete: () async {
          showMyDialogWidget(
            context,
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: const Text("No"),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  child: const Text("Yes"),
                  onPressed: () {
                    BlocProvider.of<ContactCubit>(context).delete(model.id);
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ),
            const Center(
              child: Text('Delete'),
            ),
          );
        },
      );
}
