import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListTileWidget extends StatelessWidget {
  final String title;
  final String phone;
  final String id;
  final Function() onTap;
  final Function() onDelete;
  const ListTileWidget({
    Key? key,
    required this.title,
    required this.phone,
    required this.id,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      onLongPress: () async {
        await launch('tel:$phone');
      },
      title: Text(title),
      subtitle: Text(phone),
      trailing: IconButton(
        onPressed: onDelete,
        icon: const Icon(
          Icons.delete_forever,
          color: Colors.red,
        ),
      ),
    );
  }
}
