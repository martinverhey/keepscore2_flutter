import 'package:flutter/material.dart';

Future<T?> navigateToPage<T>({
  required BuildContext context,
  required Widget page,
  bool fullScreen = false,
}) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => page,
      fullscreenDialog: fullScreen,
    ),
  );
}
