import 'dart:convert';
import 'package:http/http.dart' as http;
import 'task_model.dart';

class ApiService {
  static const String loginUrl = 'https://www.homs.com.np/api/login';
  static const String tasksUrl = 'https://api.yourdomain.com/tasks'; // Update with your actual tasks URL

  Future<bool> login(String username, String password) async {
    final response = await http.get(Uri.parse('$loginUrl?username=$username&password=$password'));
    if (response.statusCode == 200) {
      
      return jsonDecode(response.body)['success'];
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<List<Task>> fetchTasks(String serverAddress) async {
    final response = await http.get(Uri.parse(serverAddress));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Task> tasks = body.map((dynamic item) => Task.fromJson(item)).toList();
      return tasks;
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<Task> addTask(Task task, String serverAddress) async {
    final response = await http.post(
      Uri.parse(serverAddress),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()),
    );
    if (response.statusCode == 201) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add task');
    }
  }
}
