import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:motasa_dummy_app/configs/functions/functions.dart';
import 'package:motasa_dummy_app/constant/constant.dart';
import 'package:motasa_dummy_app/screens/dashboard_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String route = "/register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController repeatPasswordTextController =
      TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode repeatPasswordFocusNode = FocusNode();
  bool secureText = true;

  Future<void> doRegister() async {
    try {
      if (validation()) {
        Get.defaultDialog(
          title: "Memproses!",
          content: const CircularProgressIndicator(
            color: ColourTemplate.blue,
          ),
          barrierDismissible: false,
        );
        final Map userInfo = await registerAction(
          nameTextController.text,
          emailTextController.text,
          passwordTextController.text,
          repeatPasswordTextController.text,
        );
        Get.offAllNamed(DashboardScreen.route, arguments: userInfo);
      }
    } catch (error) {
      Get.back(); // close loading dialog
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

  bool validation() {
    if (nameTextController.text.trim().isEmpty) {
      Get.defaultDialog(
        title: "Peringatan!",
        content: const Text("Nama harus diisi!"),
        textConfirm: "Mengerti",
        buttonColor: Colors.transparent,
        confirmTextColor: ColourTemplate.blue,
        onConfirm: () => Get.back(),
      );
      return false;
    } else if (emailTextController.text.trim().isEmpty) {
      Get.defaultDialog(
        title: "Peringatan!",
        content: const Text("Email harus diisi!"),
        textConfirm: "Mengerti",
        buttonColor: Colors.transparent,
        confirmTextColor: ColourTemplate.blue,
        onConfirm: () => Get.back(),
      );
      return false;
    } else if (passwordTextController.text.length < 8) {
      Get.defaultDialog(
        title: "Peringatan!",
        content: const Text("Password harus diisi minimal 8 karakter!"),
        textConfirm: "Mengerti",
        buttonColor: Colors.transparent,
        confirmTextColor: ColourTemplate.blue,
        onConfirm: () => Get.back(),
      );
      return false;
    } else if (repeatPasswordTextController.text != passwordTextController.text) {
      Get.defaultDialog(
        title: "Peringatan!",
        content: const Text("Password tidak sesuai!"),
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
                  "Buat Akun Anda!",
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
                  // *Name
                  const Text(
                    "name",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColourTemplate.lightGray,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: nameTextController,
                    focusNode: nameFocusNode,
                    style: const TextStyle(
                      color: ColourTemplate.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.white70),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                    style: const TextStyle(
                      color: ColourTemplate.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
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
                  const SizedBox(height: 16),
                  // *Repeat Password
                  const Text(
                    "Ketik Ulang Password",
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
                        controller: repeatPasswordTextController,
                        focusNode: repeatPasswordFocusNode,
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
                  // *Register Button
                  ElevatedButton(
                    onPressed: () => doRegister(),
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
                      "Daftar",
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
          ],
        ),
      ),
    );
  }
}
