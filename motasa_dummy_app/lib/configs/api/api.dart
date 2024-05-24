// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class ApiConfig {
  static const String url = "https://terra.matetrick.com/api";
  static const String urlStorage = "https://terra.matetrick.com/storage";

  late http.Client client;

  // ? Login
  Future<Map> login(String email, String password) async {
    try {
      client = http.Client();
      final Map body = {
        "email": email,
        "password": password,
      };
      http.Response response = await client.post(
        Uri.parse("${url}/auth/login"),
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
      Map result = jsonDecode(response.body)["data"];
      return Future.value(result);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Register
  Future<Map> register(
    String name,
    String email,
    String password,
    String repeat_password,
  ) async {
    try {
      client = http.Client();
      final Map body = {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": repeat_password,
        "role_id": "2",
      };
      http.Response response = await client.post(
        Uri.parse("${url}/auth/register"),
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
      final Map result = jsonDecode(response.body)["data"];
      return Future.value(result);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Logout
  Future<void> logout(String token, String token_type) async {
    try {
      client = http.Client();
      http.Response response = await client.post(
        Uri.parse("${url}/auth/logout"),
        headers: {
          'Authorization': '${token_type} ${token}',
        },
        body: {},
      );
      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)["errors"]);
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Upload Customer's Outlet
  Future<void> addNewCustomerOutlet(
    String outlet_name,
    String name,
    String phone,
    String address,
    String postal_code,
    String city,
    String latitude,
    String longitude,
    Uint8List image,
    String token_type,
    String token,
  ) async {
    try {
      final Map<String, String> customerFields = <String, String>{
        "outlet_name": outlet_name,
        "phone": phone,
        "address": address,
        "postal_code": postal_code,
        "city": city,
        "latitude": latitude,
        "longitude": longitude,
      };
      final http.MultipartRequest request = http.MultipartRequest(
        "POST",
        Uri.parse("${url}/customers"),
      );
      request.headers.addAll({
        'Authorization': '${token_type} ${token}',
      });
      request.fields.addAll(customerFields);
      request.files.add(http.MultipartFile.fromBytes(
        "photo",
        image,
        filename: "image_${outlet_name}_${name}",
      ));
      final http.StreamedResponse response = await request.send();
      final responseByteArray = await response.stream.toBytes();
      final decodedResponse = jsonDecode(utf8.decode(responseByteArray));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(decodedResponse);
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Get Custeomer's Outlet
  Future<List> getOutlets(String token, String token_type) async {
    try {
      client = http.Client();
      http.Response response = await client.get(
        Uri.parse("${url}/customers"),
        headers: {
          'Authorization': '${token_type} ${token}',
        },
      );
      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body));
      }
      List result = jsonDecode(response.body)["data"];
      return Future.value(result);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Get Cities
  Future<List> getListCities(String token, String token_type) async {
    try {
      client = http.Client();
      http.Response response = await client.get(
        Uri.parse("${url}/cities"),
        headers: {
          'Authorization': '${token_type} ${token}',
        },
      );
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
      List result = jsonDecode(response.body)["data"];
      return Future.value(result);
    } catch (error) {
      return Future.error(error);
    }
  }
}
