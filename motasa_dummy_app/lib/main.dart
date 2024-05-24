import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motasa_dummy_app/constant/constant.dart';
import 'package:motasa_dummy_app/screens/login_screen.dart';
import 'package:motasa_dummy_app/screens/register_screen.dart';
import 'package:motasa_dummy_app/screens/splash_screen.dart';
import 'package:motasa_dummy_app/screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motasa',
      theme: ThemeData(
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSeed(
          primary: ColourTemplate.blue,
          seedColor: ColourTemplate.blue,
        ),
        useMaterial3: true,
      ),
      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 200),
      initialRoute: SplashScreen.route,
      getPages: [
        GetPage(
          name: SplashScreen.route,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: LoginScreen.route,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: RegisterScreen.route,
          page: () => const RegisterScreen(),
        ),
        GetPage(
          name: DashboardScreen.route,
          page: () => const DashboardScreen(),
        ),
      ],
    );
  }
}