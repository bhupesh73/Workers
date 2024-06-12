import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/model.dart';

class DataDashboard extends StatefulWidget {
  const DataDashboard({Key? key}) : super(key: key);

  @override
  State<DataDashboard> createState() => _DataDashboardState();
}

class _DataDashboardState extends State<DataDashboard> {
  late Future<DashboardDetails> _dashboardDetailsFuture;

  @override
  void initState() {
    super.initState();
    _dashboardDetailsFuture = fetchData();
  }

  Future<DashboardDetails> fetchData() async {
    final response =
        await http.get(Uri.parse('https://www.homs.com.np/api/dashboard/5'));
    if (response.statusCode == 200) {
      try {
        var jsonData = jsonDecode(response.body);
        var workers = Workers.fromJson(jsonData);
        return workers.dashboardDetails;
      } catch (e) {
        print('Error parsing JSON: $e');
        throw Exception('Error parsing JSON: $e');
      }
    } else {
      throw Exception(
          'Failed to load data with status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Dashboard'),
      ),
      body: FutureBuilder<DashboardDetails>(
        future: _dashboardDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkAssignedDetailsPage(
                              workorders: snapshot.data!.workordersAssigned,
                            ),
                          ),
                        );
                      },
                      child: Text('Work Order Assigned'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkPreventiveDetailsPage(
                              workorders:
                                  snapshot.data!.recentWorkordersPreventive,
                            ),
                          ),
                        );
                      },
                      child: Text('Work Order Preventives'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkCorrectiveDetailsPage(
                              workorders:
                                  snapshot.data!.recentWorkordersCorrective,
                            ),
                          ),
                        );
                      },
                      child: Text('Work Order correctives'),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class WorkAssignedDetailsPage extends StatelessWidget {
  final List<RecentWorkordersPreventive> workorders;

  const WorkAssignedDetailsPage({Key? key, required this.workorders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work Assigned Details'),
      ),
      body: ListView.builder(
        itemCount: workorders.length,
        itemBuilder: (context, index) {
          var workorder = workorders[index];
          return ListTile(
            title: Text('Workorder ID: ${workorder.id}'),
            subtitle: Text('Status: ${workorder.status}'),
          );
        },
      ),
    );
  }
}

class WorkPreventiveDetailsPage extends StatelessWidget {
  final List<RecentWorkordersPreventive> workorders;

  const WorkPreventiveDetailsPage({Key? key, required this.workorders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work Preventive Details'),
      ),
      body: ListView.builder(
        itemCount: workorders.length,
        itemBuilder: (context, index) {
          var workorder = workorders[index];
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text('Workorder ID: ${workorder.id}'),
              subtitle: Text('Status: ${workorder.status}'),
            ),
          );
        },
      ),
    );
  }
}

class WorkCorrectiveDetailsPage extends StatelessWidget {
  final List<RecentWorkordersCorrective> workorders;

  const WorkCorrectiveDetailsPage({Key? key, required this.workorders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work Corrective Details'),
      ),
      body: ListView.builder(
        itemCount: workorders.length,
        itemBuilder: (context, index) {
          var workorder = workorders[index];
          return ListTile(
            title: Text('Workorder ID: ${workorder.id}'),
            subtitle: Text('Status: ${workorder.status}'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Workorder Details'),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID: ${workorder.id}'),
                        Text('Name: ${workorder.woName}'),
                        Text('Description: ${workorder.description}'),
                        Text('Priority: ${workorder.priority}'),
                        Text('Status: ${workorder.status}'),
                        Text('Scheduled Date: ${workorder.scheduleFirstDate}'),
                        Text('Crew Size: ${workorder.crewSize}'),
                        Text(
                            'Estimated Manpower Hour: ${workorder.estimatedManpowerHour}'),
                        Text('Safety Measures: ${workorder.safetyMeasures}'),
                        Text('Created At: ${workorder.createdAt}'),
                        Text('Updated At: ${workorder.updatedAt}'),
                        Text('Last Generated At: ${workorder.lastGeneratedAt}'),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Close'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
