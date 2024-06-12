import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginuicolors/worker_login/page/workassigneddetailpage.dart';
import 'package:loginuicolors/worker_login/page/workcorrecive.dart';
import 'package:loginuicolors/worker_login/page/workpreventive.dart';
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
                child: Column(
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
                      child: Text('Work Order Correctives'),
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
