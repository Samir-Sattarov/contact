import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/database/database_cubit.dart';
import 'package:flutter_application_1/cubit/network/network_cubit.dart';
import 'package:flutter_application_1/cubit/network/network_state.dart';

import 'package:flutter_application_1/model/contact_model.dart';
import 'package:flutter_application_1/pages/add_model_page.dart';
import 'package:flutter_application_1/pages/auth/sign_out_page.dart';
import 'package:flutter_application_1/pages/update_model_page.dart';
import 'package:flutter_application_1/widget/alert_dialog_widget.dart';
import 'package:flutter_application_1/widget/list_tile_widget.dart';
import 'package:flutter_application_1/widget/search_field_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomePage());
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
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            SignOutPage.route(),
          ),
          icon: const Icon(Icons.exit_to_app),
        ),
        elevation: 5,
        title: const Text('Contact Book'),
        actions: [
          IconButton(
            onPressed: _onAppbarIconButtonPress,
            icon: BlocConsumer<NetworkCubit, NetworkState>(
              listener: _listener,
              builder: _buildIcon,
            ),
          ),
          IconButton(
            onPressed: () => BlocProvider.of<DatabaseCubit>(context)
                .deleteAllFromAllDatabase(),
            icon: const Icon(Icons.restore_from_trash),
          ),
        ],
      ),
      body: Column(
        children: [
          buildSearch(),
          BlocBuilder<DatabaseCubit, List<ContactModel>>(builder: _buildBody),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFloatingAActionButtonPress,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(context, contact) {
    return Expanded(
      child: ListView.builder(
        itemCount: contact.length,
        itemBuilder: (BuildContext context, int index) {
          final model = contact[index];
          return buildModel(model);
        },
      ),
    );
  }

  void _listener(context, state) {
    if (state is NetworkConnectedState) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Connected",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    if (state is NetworkDisconnectedState) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Disconnected",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  _onFloatingAActionButtonPress() async {
    final isAdded = await Navigator.push(
      context,
      AddModelPage.route(),
    );
    if (isAdded != null && isAdded == true) {
      BlocProvider.of<DatabaseCubit>(context).getAll();
    }
  }

  void _onAppbarIconButtonPress() async {
    BlocProvider.of<DatabaseCubit>(context).getAll();
  }

  Widget _buildIcon(context, state) {
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
      state is NetworkConnectedState ? Icons.cloud : Icons.cloud_off_rounded,
    ));
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search',
        onChanged: search,
      );

  void search(String query) {
    BlocProvider.of<DatabaseCubit>(context).search(query);
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
            BlocProvider.of<DatabaseCubit>(context).getAll();
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
                    BlocProvider.of<DatabaseCubit>(context).delete(model.id);
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
