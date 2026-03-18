import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';

class ApiService {
  static const String baseUrl = 'https://fullstack-me1i.onrender.com/api';

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final token = await getToken();
    return http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }

  Future<http.Response> get(String endpoint) async {
    final token = await getToken();
    return http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final token = await getToken();
    return http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }

  Future<http.Response> delete(String endpoint) async {
    final token = await getToken();
    return http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
  }
}
