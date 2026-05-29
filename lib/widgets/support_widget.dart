import "package:flutter/material.dart";

import 'package:shopping_app/main.dart';

class AppWidget {
  static TextStyle boldTextStyle() {
    return TextStyle(
      color: isDarkModeNotifier.value ? Colors.white : Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 28,
    );
  }

  static TextStyle lightTextStyle() {
    return TextStyle(
      color: isDarkModeNotifier.value ? Colors.white54 : Colors.black54,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle semiBoldTextStyle() {
    return TextStyle(
      color: isDarkModeNotifier.value ? Colors.white : Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }
}
