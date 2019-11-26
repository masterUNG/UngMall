

import 'package:flutter/material.dart';

Future<void> normalDialog(
    BuildContext buildContext, String title, String message) async {
  showDialog(
    context: buildContext,
    builder: (BuildContext buildContext) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(buildContext).pop();
            },
          )
        ],
      );
    },
  );
}
