import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/api_service.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];
  bool _loading = false;
  Map<String, int> _stats = {'total': 0, 'completed': 0, 'pending': 0};
  final ApiService _apiService = ApiService();

  List<TaskModel> get tasks => _tasks;
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
        await fetchStats();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchStats() async {
    try {
      final response = await _apiService.get('/tasks/stats');
      final data = jsonDecode(response.body);
      if (data['success']) {
        _stats = Map<String, int>.from(data['data']);
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
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
}
