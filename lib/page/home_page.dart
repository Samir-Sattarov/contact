import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/database.dart';
import 'package:flutter_application_1/model/list_tile_model.dart';
import 'package:flutter_application_1/page/add_model_page.dart';
import 'package:flutter_application_1/page/update_model_page.dart';
import 'package:flutter_application_1/widget/alert_dialog_widget.dart';
import 'package:flutter_application_1/widget/list_tile_widget.dart';
import 'package:flutter_application_1/widget/search_field_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactDataBaseProvider memoDb = ContactDataBaseProvider();
  List<ListTileModel> contact = [];
  String query = '';
  @override
  void initState() {
    super.initState();
    initialization();
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
              refresh();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          buildSearch(),
          Expanded(
            child: ListView.builder(
              itemCount: contact.length,
              itemBuilder: (BuildContext context, int index) {
                final model = contact[index];
                return buildModel(model);
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final isAdded =
              await Navigator.push(context, AddModelPage.route(memoDb));
          if (isAdded != null && isAdded == true) {
            refresh();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<List<ListTileModel>> initialization() async {
    contact = await memoDb.fetchMemos();
    setState(() {
      contact;
    });
    return contact = await memoDb.fetchMemos();
  }

  Future refresh() async {
    contact = await memoDb.fetchMemos();
    setState(() {
      contact;
    });
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search',
        onChanged: search,
      );

  void search(String query) {
    if (query.isEmpty) {
      refresh();
    } else {
      List<ListTileModel> searched = contact.where((model) {
        final titlelower = model.title.toLowerCase();
        final phonelower = model.phone.toLowerCase();
        final searchlower = query.toLowerCase();

        return titlelower.contains(searchlower) ||
            phonelower.contains(searchlower);
      }).toList();
      setState(() {
        query = query;

        contact = searched;
      });
    }
  }

  Widget buildModel(ListTileModel model) => ListTileWidget(
        title: model.title,
        phone: model.phone,
        id: model.id.toString(),
        onTap: () async {
          final result = await Navigator.push<bool>(
            context,
            UpdateModelPage.route(
              memoDb,
              model.title,
              model.phone,
              model.id!.toInt(),
            ),
          );
          if (result != null && result) {
            await refresh();
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
                    refresh();
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ),
            const Center(
              child: Text('Delete'),
            ),
          );
          await memoDb.deleteMemo(model.id!);
          memoDb.fetchMemos();
        },
      );
}
