import 'dart:convert';
import 'package:flutter/material.dart';

import 'api.service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daily_training_flutter/services/users.service.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  static instancePrefs() async {
    return await SharedPreferences.getInstance();
  }

  static Future<String?> getAccessToken() async {
    final prefs = await instancePrefs();
    return prefs.getString("accessToken");
  }

  static getUserData() async {
    final prefs = await instancePrefs();
    final String? userDataString = prefs.getString("userData");

    if (userDataString != null) {
      try {
        return User.fromJson(jsonDecode(userDataString));
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  static Future<void> setBetDetailsId(int? betId) async {
    final prefs = await instancePrefs();
    return await prefs.setInt("betId", betId);
  }

  static Future<int> getBetDetailsId() async {
    final prefs = await instancePrefs();
    return await prefs.getInt("betId");
  }

  static Future<void> signup(context) async {
    final prefs = await instancePrefs();
    await prefs.remove('userData');
    await prefs.remove('accessToken');

    await Navigator.pushNamed(context, '/');
  }

  Future<void> signin(String email, String password) async {
    final response = await _apiService.post("/auth/login", {
      "email": email,
      "password": password,
    });

    if (response.containsKey("accessToken")) {
      try {
        final prefs = await instancePrefs();
        await prefs.setString("accessToken", response["accessToken"]);

        final userEncoded = jsonEncode(response["user"]);
        await prefs.setString("userData", userEncoded);
      } catch (e) {
        throw Exception("Erro ao salvar o token ou dados do usuário: $e");
      }
    } else {
      throw Exception("Token de acesso não encontrado");
    }
  }
}