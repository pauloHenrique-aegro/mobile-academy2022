import 'package:flutter/material.dart';

Future<void> showModalBottom(BuildContext context, Widget child) {
  return showModalBottomSheet(
    context: context,
    builder: (_) {
      return GestureDetector(
        onTap: () {},
        child: child,
        behavior: HitTestBehavior.opaque,
      );
    },
  );
}
