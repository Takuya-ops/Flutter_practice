import 'package:flutter/material.dart';

class Utils {
  static showSnackbar(context, message, seconds) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: seconds),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
