// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  late SharedPreferences prefs;

  Future<void> setUserLogin({
    required String token,
    required String token_type,
    required String name,
    required String email,
    required int id,
  }) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    prefs.setString("token_type", token_type);
    prefs.setString("name", name );
    prefs.setString("email", email);
    prefs.setInt("id", id);
  }

  Future<Map> getUserProfile() async {
    prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("name") ?? "";
    String email = prefs.getString("email") ?? "";
    String token = prefs.getString("token") ?? "";
    String token_type = prefs.getString("token_type") ?? "";
    int id = prefs.getInt("id") ?? 0;
    return {
      "name": name,
      "email": email,
      "token": token,
      "token_type": token_type,
      "id": id,
    };
  }

  Future<void> deleteUser() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
