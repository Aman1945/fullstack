import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  String? _token;
  bool _loading = false;
  final ApiService _apiService = ApiService();

  UserModel? get user => _user;
  String? get token => _token;
  bool get isLoading => _loading;
  bool get isAuthenticated => _token != null;

  AuthProvider() {
    _loadStoredData();
  }

  Future<void> _loadStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    final userJson = prefs.getString('user');
    if (userJson != null) {
      _user = UserModel.fromJson(jsonDecode(userJson));
    }
    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    _loading = true;
    notifyListeners();
    try {
      final response = await _apiService.post('/auth/login', {
        'email': email,
        'password': password,
      });

      final data = jsonDecode(response.body);
      if (data['success']) {
        _token = data['token'];
        _user = UserModel.fromJson(data['user']);
        
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        await prefs.setString('user', jsonEncode(data['user']));
        
        _loading = false;
        notifyListeners();
        return null;
      } else {
        _loading = false;
        notifyListeners();
        return data['message'];
      }
    } catch (e) {
      _loading = false;
      notifyListeners();
      return e.toString();
    }
  }

  Future<String?> register(String name, String email, String password) async {
    _loading = true;
    notifyListeners();
    try {
      final response = await _apiService.post('/auth/register', {
        'name': name,
        'email': email,
        'password': password,
      });

      final data = jsonDecode(response.body);
      if (data['success']) {
        _token = data['token'];
        _user = UserModel.fromJson(data['user']);
        
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        await prefs.setString('user', jsonEncode(data['user']));
        
        _loading = false;
        notifyListeners();
        return null;
      } else {
        _loading = false;
        notifyListeners();
        return data['message'];
      }
    } catch (e) {
      _loading = false;
      notifyListeners();
      return e.toString();
    }
  }

  Future<void> logout() async {
    _token = null;
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
    notifyListeners();
  }
}
