import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/contact/contact_cubit.dart';
import 'package:flutter_application_1/bloc/network/network_cubit.dart';
import 'package:flutter_application_1/bloc/network/network_state.dart';
import 'package:flutter_application_1/db/local_contact_repository.dart';
import 'package:flutter_application_1/model/contact_model.dart';
import 'package:flutter_application_1/page/add_model_page.dart';
import 'package:flutter_application_1/page/update_model_page.dart';
import 'package:flutter_application_1/widget/alert_dialog_widget.dart';
import 'package:flutter_application_1/widget/list_tile_widget.dart';
import 'package:flutter_application_1/widget/search_field_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text('Contact Book Application'),
        actions: [
          IconButton(onPressed: () async {
            BlocProvider.of<ContactCubit>(context).getAll();
          }, icon: BlocBuilder<NetworkCubit, NetworkState>(
            builder: (context, state) {
              if (state is NetworkSearchingState) {
                return const SizedBox.square(
                  dimension: 20.0,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.0,
                  ),
                );
              }

              return SizedBox.square(
                  child: Icon(
                state is NetworkConnectedState
                    ? Icons.cloud
                    : Icons.cloud_off_rounded,
              ));
            },
          )),
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
          if (result != null && result == true) {
            BlocProvider.of<ContactCubit>(context).getAll();
          }
        },
        onDelete: () {
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
