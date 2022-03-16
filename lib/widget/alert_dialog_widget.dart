import 'package:flutter/material.dart';

Future showMyDialogWidget(context, Widget content, Widget title) async {
  return showDialog<dynamic>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: title,
        content: content,
      );
    },
  );
}
