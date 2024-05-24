import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motasa_dummy_app/configs/functions/functions.dart';
import 'package:motasa_dummy_app/constant/constant.dart';
import 'package:motasa_dummy_app/screens/dashboard_screen.dart';
import 'package:motasa_dummy_app/screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String route = "/splash";

  Future<void> checkUserExist() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    final Map? userInfo = await getExistingUser();
    if (userInfo != null) {
      Get.offNamed(DashboardScreen.route, arguments: userInfo);
    } else {
      Get.offNamed(LoginScreen.route);
    }

  }

  @override
  Widget build(BuildContext context) {
    checkUserExist();
    return const Scaffold(
      backgroundColor: ColourTemplate.blue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Image(
                image: AssetImage(ImageTemplate.logo),
                width: 94,
                height: 94,
              ),
            ),
          ),
          Column(
            children: [
              Text(
                "Motasa Dummy App",
                style: TextStyle(
                  color: ColourTemplate.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "App For Customer",
                style: TextStyle(
                  color: ColourTemplate.whiteWithOpacity60,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "v1.0.0",
                style: TextStyle(
                  color: ColourTemplate.whiteWithOpacity60,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
