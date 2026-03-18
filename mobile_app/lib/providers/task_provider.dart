import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../models/contact_model.dart';
import '../services/api_service.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];
  List<ContactModel> _contacts = [];
  bool _loading = false;
  Map<String, int> _stats = {'total': 0, 'completed': 0, 'pending': 0};
  final ApiService _apiService = ApiService();

  List<TaskModel> get tasks => _tasks;
  List<ContactModel> get contacts => _contacts;
  bool get isLoading => _loading;
  Map<String, int> get stats => _stats;

  Future<void> fetchTasks() async {
    _loading = true;
    notifyListeners();
    try {
      final response = await _apiService.get('/tasks');
      final data = jsonDecode(response.body);
      if (data['success']) {
        _tasks = (data['data'] as List)
            .map((item) => TaskModel.fromJson(item))
            .toList();
        _calculateStats();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchContacts() async {
    _loading = true;
    notifyListeners();
    try {
      final response = await _apiService.get('/contact');
      final data = jsonDecode(response.body);
      if (data['success']) {
        _contacts = (data['data'] as List)
            .map((item) => ContactModel.fromJson(item))
            .toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void _calculateStats() {
    int total = _tasks.length;
    int completed = _tasks.where((t) => t.status == 'completed').length;
    int pending = total - completed;
    
    _stats = {
      'total': total,
      'completed': completed,
      'pending': pending,
    };
    notifyListeners();
  }

  Future<String?> addTask(String title, String description) async {
    try {
      final response = await _apiService.post('/tasks', {
        'title': title,
        'description': description,
      });
      final data = jsonDecode(response.body);
      if (data['success']) {
        await fetchTasks();
        return null;
      }
      return data['message'];
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> toggleTaskStatus(TaskModel task) async {
    final newStatus = task.status == 'completed' ? 'pending' : 'completed';
    try {
      final response = await _apiService.put('/tasks/${task.id}', {
        'status': newStatus,
      });
      final data = jsonDecode(response.body);
      if (data['success']) {
        await fetchTasks();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      final response = await _apiService.delete('/tasks/$id');
      final data = jsonDecode(response.body);
      if (data['success']) {
        await fetchTasks();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String?> updateTask(String id, String title, String description) async {
    try {
      final response = await _apiService.put('/tasks/$id', {
        'title': title,
        'description': description,
      });
      final data = jsonDecode(response.body);
      if (data['success']) {
        await fetchTasks();
        return null;
      }
      return data['message'];
    } catch (e) {
      return e.toString();
    }
  }
}
