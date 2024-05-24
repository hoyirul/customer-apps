// ignore_for_file: non_constant_identifier_names

import 'package:motasa_dummy_app/configs/api/api.dart';
import 'package:motasa_dummy_app/configs/preferences/preferences.dart';

Preferences preferences = Preferences();
ApiConfig api = ApiConfig();

Future<Map?> getExistingUser() async {
  final Map userInfo = await preferences.getUserProfile();
  if (userInfo["id"] == 0) {
    return null;
  }
  return userInfo;
}

Future<Map> loginAction(
  String email,
  String password,
) async {
  try {
    final Map response = await api.login(email, password);
    await preferences.setUserLogin(
      token: response["access_token"],
      token_type: response["token_type"],
      name: response["user"]["name"],
      email: response["user"]["email"],
      id: response["user"]["id"],
    );
    final Map userInfo = await preferences.getUserProfile();
    if (userInfo["id"] == 0 || userInfo["id"] == null) {
      throw "Credentials not match";
    }
    return userInfo;
  } catch (error) {
    return Future.error(error);
  }
}

Future<Map> registerAction(
  String name,
  String email,
  String password,
  String repeat_password,
) async {
  try {
    final Map response =
        await api.register(name, email, password, repeat_password);
    await preferences.setUserLogin(
      token: response["access_token"],
      token_type: response["token_type"],
      name: response["user"]["name"],
      email: response["user"]["email"],
      id: response["user"]["id"],
    );
    final Map userInfo = await preferences.getUserProfile();
    if (userInfo["id"] == 0 || userInfo["id"] == null) {
      throw "Credentials not match";
    }
    return userInfo;
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> logoutAction() async {
  try {
    final Map userInfo = await preferences.getUserProfile();
    await api.logout(
      userInfo["token"],
      userInfo["token_type"],
    );
    await preferences.deleteUser();
  } catch (error) {
    return Future.error(error);
  }
}

Future<List> getCities() async {
  try {
    final Map userInfo = await preferences.getUserProfile();
    final List cities = await api.getListCities(
      userInfo["token"],
      userInfo["token_type"],
    );
    return cities;
  } catch (error) {
    return Future.error(error);
  }
}

Future<List> getCustomersOutlets() async {
  try {
    final Map userInfo = await preferences.getUserProfile();
    final List cities = await api.getOutlets(
      userInfo["token"],
      userInfo["token_type"],
    );
    return cities;
  } catch (error) {
    return Future.error(error);
  }
}
