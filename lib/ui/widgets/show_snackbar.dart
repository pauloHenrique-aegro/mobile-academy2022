import 'package:flutter/material.dart';

Future<void> showSnackCustomBar(BuildContext context, message) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.deepOrange));
}
