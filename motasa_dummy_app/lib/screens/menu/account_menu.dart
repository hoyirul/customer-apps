import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motasa_dummy_app/configs/functions/functions.dart';
import 'package:motasa_dummy_app/constant/constant.dart';
import 'package:motasa_dummy_app/screens/login_screen.dart';

class AccountMenu extends StatefulWidget {
  const AccountMenu({super.key});

  @override
  State<AccountMenu> createState() => _AccountMenuState();
}

class _AccountMenuState extends State<AccountMenu> {

  Future<void> doLogout() async {
    try {
      Get.defaultDialog(
        title: "Memproses!",
        content: const CircularProgressIndicator(
          color: ColourTemplate.blue,
        ),
        barrierDismissible: false,
      );
      await logoutAction();
      Get.offAllNamed(LoginScreen.route);
    } catch (error) {
      Get.offAllNamed(LoginScreen.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColourTemplate.background,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage(ImageTemplate.logo),
                  width: 72,
                  height: 72,
                ),
                const SizedBox(height: 28),
                const Text(
                  'Motasa Dummy App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: ColourTemplate.black,
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'App For Customer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColourTemplate.gray,
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'v1.0.0',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColourTemplate.gray,
                  ),
                ),
                const SizedBox(height: 28),
                // *Logout Button
                ElevatedButton(
                  onPressed: () => doLogout(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: ColourTemplate.blue,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Keluar",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
