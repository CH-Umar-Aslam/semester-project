import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/app_constants.dart';
import '../constants/task_method_constants.dart';
import '../models/response_model.dart';
import '../models/task_list_model.dart';
import '../models/task_model.dart';

class ApiService {
  static final ApiService _apiService = ApiService._init();

  factory ApiService() {
    return _apiService;
  }

  ApiService._init();

  // Helper function to create URI
  Uri _getUri(String path) {
    if (AppConstants.USE_HTTPS) {
      return Uri.https(AppConstants.API_BASE_URL, path);
    } else {
      return Uri.http(AppConstants.API_BASE_URL, path);
    }
  }

  // Add new task
  Future<Response> addNewTask(Task task) async {
    final url = _getUri(TaskMethodConstants.ADD_NEW_TASK);
    final request = await http.post(
      url,
      body: jsonEncode(task.toJson()),
      headers: AppConstants.HEADERS,
    );
    Response response = Response();
    try {
      if (request.statusCode == 201) {
        response = responseFromJson(request.body);
      } else {
        print(request.statusCode);
      }
    } catch (e) {
      print('Error adding task: $e');
    }
    return response;
  }

  // Update task
  Future<Response> updateTask(String name, String description, String id) async {
    final json = '{"name": "$name", "description": "$description", "id": "$id"}';
    final url = _getUri(TaskMethodConstants.UPDATE_TASK);
    final request = await http.post(url, body: json, headers: AppConstants.HEADERS);
    Response response = Response();
    try {
      if (request.statusCode == 201) {
        response = responseFromJson(request.body);
      } else {
        print(request.statusCode);
      }
    } catch (e) {
      print('Error updating task: $e');
    }
    return response;
  }

  // Delete task
  Future<Response> deleteTask(String id) async {
    final json = '{"id": "$id"}';
    final url = _getUri(TaskMethodConstants.DELETE_TASK);
    final request = await http.post(url, body: json, headers: AppConstants.HEADERS);
    Response response = Response();
    try {
      if (request.statusCode == 201) {
        response = responseFromJson(request.body);
      } else {
        print(request.statusCode);
      }
    } catch (e) {
      print('Error deleting task: $e');
    }
    return response;
  }

  // Get all tasks
  Future<List<TaskList>> getAllTasks() async {
    final url = _getUri(TaskMethodConstants.LIST_ALL_TASKS);
    final request = await http.get(url, headers: AppConstants.HEADERS);
    print("request");
    List<TaskList> tasklist = [];
    try {
      if (request.statusCode == 200) {
        print("catch");
        tasklist = taskListFromJson(request.body);
      } else {
        print(request.statusCode);
        return [];
      }
    } catch (e) {
      print('Error fetching tasks: $e');
    }
    return tasklist;
  }
}
