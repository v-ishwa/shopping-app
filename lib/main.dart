import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/admin/add_product.dart';
import 'package:shopping_app/admin/admin_login.dart';
import 'package:shopping_app/firebase_options.dart';
import 'package:shopping_app/pages/bottom_nav.dart';
import 'package:shopping_app/pages/category_products.dart';
import 'package:shopping_app/pages/home.dart';
import 'package:shopping_app/pages/login.dart';
// import 'package:shopping_app/pages/onboarding.dart';
// import 'package:shopping_app/pages/product_detail.dart';
import 'package:shopping_app/pages/signup.dart';
import 'package:shopping_app/services/shared_pref.dart';
import 'package:shopping_app/widgets/responsive_container.dart';

final ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(false);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  String? userId = await SharedPreferenceHelper().getUserId();
  bool isDark = await SharedPreferenceHelper().getTheme();
  isDarkModeNotifier.value = isDark;

  Widget initialScreen = (userId != null && userId.isNotEmpty)
      ? const BottomNav()
      : const Signup();
  runApp(MyApp(initialScreen: initialScreen));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;

  const MyApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDark, child) {
        return MaterialApp(
          title: 'Shopping App',
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: const Color(0xfff2f2f2),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xfff2f2f2),
              elevation: 0,
            ),
            colorScheme: ColorScheme.light(
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xff121212),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xff121212),
              elevation: 0,
            ),
            colorScheme: ColorScheme.dark(
              surface: const Color(0xff1e1e1e),
              onSurface: Colors.white,
            ),
            textTheme: const TextTheme(
              titleMedium: TextStyle(color: Colors.white),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          home: initialScreen,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
