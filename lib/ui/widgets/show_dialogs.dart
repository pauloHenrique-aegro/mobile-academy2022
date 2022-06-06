import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String errorMessage) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Ops! Ocorreu um erro'),
      content: Text(errorMessage),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK'))
      ],
    ),
  );
}
