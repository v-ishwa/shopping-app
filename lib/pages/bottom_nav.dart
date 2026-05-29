import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/home.dart';
import 'package:shopping_app/pages/order.dart';
import 'package:shopping_app/pages/profile.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late List<Widget> pages = [];

  late Home homePage;
  late Order order;
  late Profile profile;

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    homePage = Home();
    order = Order();
    profile = Profile();
    pages = [homePage, order, profile];
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWide = screenWidth > 800;

    return Scaffold(
      bottomNavigationBar: isWide
          ? null
          : CurvedNavigationBar(
              height: 65,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              color: Colors.black,
              animationDuration: const Duration(milliseconds: 200),
              index: currentTabIndex,
              onTap: (int index) {
                setState(() {
                  currentTabIndex = index;
                });
              },
              items: const [
                Icon(Icons.home_outlined, color: Colors.white),
                Icon(Icons.shopping_bag_outlined, color: Colors.white),
                Icon(Icons.person_outlined, color: Colors.white),
              ],
            ),
      body: isWide
          ? Row(
              children: [
                NavigationRail(
                  backgroundColor: Colors.black,
                  selectedIndex: currentTabIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      currentTabIndex = index;
                    });
                  },
                  unselectedIconTheme: const IconThemeData(color: Colors.white70),
                  selectedIconTheme: const IconThemeData(color: Colors.white),
                  labelType: NavigationRailLabelType.all,
                  unselectedLabelTextStyle: const TextStyle(color: Colors.white70),
                  selectedLabelTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.shopping_bag_outlined),
                      label: Text('Order'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outlined),
                      label: Text('Profile'),
                    ),
                  ],
                ),
                Expanded(child: pages[currentTabIndex]),
              ],
            )
          : pages[currentTabIndex],
    );
  }
}
