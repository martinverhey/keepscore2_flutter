import 'package:flutter/material.dart';

void navigateToPage({
  required BuildContext context,
  required Widget page,
  bool fullScreen = false,
  void Function()? callback,
}) {
  Navigator.of(context)
      .push(
    MaterialPageRoute(
      builder: (context) => page,
      fullscreenDialog: fullScreen,
    ),
  )
      .then((result) {
    if (callback != null && result == null) {
      callback();
    }
  });
}
