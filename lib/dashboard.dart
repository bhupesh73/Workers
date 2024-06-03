import 'dart:io';
import 'package:flutter/material.dart';
import 'package:loginuicolors/addtask.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Dashboard extends StatefulWidget {
  final Task? task;

  const Dashboard({Key? key, this.task}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Task> _tasks = [];
  List<Task> _filteredTasks = [];

  TextEditingController _searchController = TextEditingController();
  String _sortBy = 'Task Name';

  @override
  void initState() {
    super.initState();
    _refreshTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Task'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddTask()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshTasks,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search Task',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      _filterTasks(value);
                    },
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: DropdownButton<String>(
                    value: _sortBy,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
                    underline: SizedBox(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _sortBy = newValue!;
                        _sortTasks();
                      });
                    },
                    items: ['Task Name', 'Priority', 'Location'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildTaskList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTask()),
          );
          if (result != null && result is Task) {
            setState(() {
              _tasks.add(result);
              _filteredTasks.add(result);
            });
          }
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 56, 104, 152),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildTaskList() {
    if (_filteredTasks.isEmpty) {
      return Center(
        child: Text(
          'No tasks found.',
          style: TextStyle(fontSize: 18),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: _filteredTasks.length,
        itemBuilder: (context, index) {
          return _buildTaskItem(_filteredTasks[index]);
        },
      );
    }
  }

  Widget _buildTaskItem(Task task) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ListTile(
          title: Text(
            task.taskName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
              fontFamily: 'Roboto',
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text(
                "Description: ${task.description}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 4),
              Text(
                "Priority: ${task.priority}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 4),
              Text(
                "Location: ${task.location}",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sortTasks() {
    switch (_sortBy) {
      case 'Task Name':
        _filteredTasks.sort((a, b) => a.taskName.compareTo(b.taskName));
        break;
      case 'Priority':
        _filteredTasks.sort((a, b) => a.priority.compareTo(b.priority));
        break;
      case 'Location':
        _filteredTasks.sort((a, b) => a.location.compareTo(b.location));
        break;
    }
  }

  void _filterTasks(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _filteredTasks = _tasks
            .where((task) =>
                task.taskName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        _filteredTasks = List.from(_tasks);
      });
    }
  }

  void _refreshTasks() {
    setState(() {
      _filteredTasks = List.from(_tasks);
      _filterTasks(_searchController.text);
    });
  }
}

class Task {
  final String taskName;
  final String description;
  final String priority;
  final String location;

  Task({
    required this.taskName,
    required this.description,
    required this.priority,
    required this.location,
    File? image,
  });
}