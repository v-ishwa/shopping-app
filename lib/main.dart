import 'package:flutter/material.dart';
import 'package:shopping_app/pages/bottom_nav.dart';
import 'package:shopping_app/pages/home.dart';
import 'package:shopping_app/pages/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const BottomNav(),
      debugShowCheckedModeBanner: false,
    );
  }
}
