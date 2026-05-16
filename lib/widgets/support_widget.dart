import "package:flutter/material.dart";

class AppWidget {
  static TextStyle boldTextStyle() {
    return TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 28,
    );
  }

  static TextStyle lightTextStyle() {
    return TextStyle(
      color: Colors.black54,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle semiBoldTextStyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }
}
