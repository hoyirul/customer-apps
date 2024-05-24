import 'package:flutter/material.dart';
import 'package:motasa_dummy_app/constant/constant.dart';
import 'package:motasa_dummy_app/screens/menu/account_menu.dart';
import 'package:motasa_dummy_app/screens/menu/dashboard_menu.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const String route = "/dashboard";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedMenu = 0;

  Widget showMenu() {
    if (selectedMenu == 0) {
      return const DashboardMenu();
    }
    return const AccountMenu();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: showMenu(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              selectedMenu = index;
            });
          },
          currentIndex: selectedMenu,
          elevation: 4,
          selectedItemColor: ColourTemplate.blue,
          unselectedItemColor: ColourTemplate.gray,
          selectedLabelStyle: const TextStyle(
            color: ColourTemplate.blue,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: const TextStyle(
            color: ColourTemplate.gray,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              label: "Beranda",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Akun",
            ),
          ],
        ),
      ),
    );
  }
}
