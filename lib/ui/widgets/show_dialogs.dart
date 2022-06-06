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

Future<void> showAlertDialog(BuildContext context, void event) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('ATENÇÃO!'),
      content: const Text(
          'Este dado não poderá mais ser exlcuído ou alterado neste dispositivo. Deseja continuar?'),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              event;
              Navigator.of(ctx).pop();
            },
            child: const Text('OK')),
        TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('CANCELAR'))
      ],
    ),
  );
}
