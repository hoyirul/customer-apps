import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:motasa_dummy_app/configs/functions/functions.dart';
import 'package:motasa_dummy_app/constant/constant.dart';
import 'package:motasa_dummy_app/screens/dashboard_screen.dart';
import 'package:motasa_dummy_app/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String route = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool secureText = true;

  Future<void> doLogin() async {
    try {
      if (validation()) {
        Get.defaultDialog(
          title: "Memproses!",
          content: const CircularProgressIndicator(
            color: ColourTemplate.blue,
          ),
          barrierDismissible: false,
        );
        final Map userInfo = await loginAction(
          emailTextController.text,
          passwordTextController.text,
        );
        Get.offAllNamed(DashboardScreen.route, arguments: userInfo);
      }
    } catch (error) {
      Get.back(); // close loading dialog
      if (error.toString().contains("Credentials not match")) {
        Get.defaultDialog(
          title: "Info!",
          content: const Text("Pengguna tidak ditemukan!"),
          textConfirm: "Mengerti",
          buttonColor: Colors.transparent,
          confirmTextColor: ColourTemplate.blue,
          onConfirm: () => Get.back(),
        );
      } else {
        Get.defaultDialog(
          title: "Terjadi Kesalahan!",
          content: Text(error.toString()),
          textConfirm: "Mengerti",
          buttonColor: Colors.transparent,
          confirmTextColor: ColourTemplate.blue,
          onConfirm: () => Get.back(),
        );
      }
    }
  }

  bool validation() {
    if (emailTextController.text.trim().isEmpty) {
      Get.defaultDialog(
        title: "Peringatan!",
        content: const Text("Email harus diisi!"),
        textConfirm: "Mengerti",
        buttonColor: Colors.transparent,
        confirmTextColor: ColourTemplate.blue,
        onConfirm: () => Get.back(),
      );
      return false;
    } else if (passwordTextController.text.trim().isEmpty) {
      Get.defaultDialog(
        title: "Peringatan!",
        content: const Text("Password harus diisi!"),
        textConfirm: "Mengerti",
        buttonColor: Colors.transparent,
        confirmTextColor: ColourTemplate.blue,
        onConfirm: () => Get.back(),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 28),
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // *Logo & Welcome
                Image(
                  image: AssetImage(ImageTemplate.logo),
                  width: 72,
                  height: 72,
                ),
                SizedBox(height: 16),
                Text(
                  "Selamat Datang!",
                  style: TextStyle(
                    color: ColourTemplate.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                  style: TextStyle(
                    color: ColourTemplate.gray,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 32),
            // *Login Form
            Form(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // *Email
                  const Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColourTemplate.lightGray,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: emailTextController,
                    focusNode: emailFocusNode,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                    style: const TextStyle(
                      color: ColourTemplate.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.white70),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // *Password
                  const Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColourTemplate.lightGray,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      TextFormField(
                        controller: passwordTextController,
                        focusNode: passwordFocusNode,
                        style: const TextStyle(
                          color: ColourTemplate.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: secureText,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(12, 4, 28, 4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.white70),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // *Login Button
                  ElevatedButton(
                    onPressed: () => doLogin(),
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
                      "Masuk",
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
            const SizedBox(height: 48),
            const Center(
              child: Text(
                "Belum memiliki akun?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ColourTemplate.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // *Go to Register Screen
            ElevatedButton(
              onPressed: () {
                Get.toNamed(RegisterScreen.route);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: ColourTemplate.transparentBue,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
              ),
              child: const Text(
                "Daftar Sekarang",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
