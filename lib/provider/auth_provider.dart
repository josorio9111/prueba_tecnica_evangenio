import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prueba_tecnica_evangenio/models/auth_response.dart';
import 'package:prueba_tecnica_evangenio/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  ResponseUsuario? usuario;
  String message = '';
  bool loadding = false;

  Future<bool> login(String email, String password) async {
    loadding = true;
    notifyListeners();
    final url = Uri.https('api.escuelajs.co', 'api/v1/auth/login');
    final body = {'email': email, 'password': password};
    final result = await http.post(url, body: body);
    final decodeData = json.decode(result.body);
    final response = ResponseLogin.fromJson(decodeData);
    bool aux;
    if (response.message != null) {
      message = response.message!;
      aux = false;
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response.accessToken.toString());
      aux = true;
    }
    loadding = false;
    notifyListeners();
    return aux;
  }

  Future<bool> auth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = Uri.https('api.escuelajs.co', 'api/v1/auth/profile');
    final result = await http.get(url,
        headers: {"Authorization": "Bearer ${prefs.getString('token')}"});
    final decodeData = json.decode(result.body);
    final response = ResponseUsuario.fromJson(decodeData);
    if (response.message != null) {
      message = response.message!;
      notifyListeners();
      return false;
    } else {
      usuario = response;
      prefs.setString('email', usuario!.email!);
      prefs.setString('name', usuario!.name!);
      prefs.setString('role', usuario!.role!);
      notifyListeners();
      return true;
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('name');
    await prefs.remove('role');
    await prefs.remove('token');
    usuario = null;
    message = 'Logout';
  }

  nitify() {
    notifyListeners();
  }
}
