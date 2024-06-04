import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/model.dart';

class DataDashboard extends StatelessWidget {
  const DataDashboard({Key? key}) : super(key: key);

  Future<DashboardDetails> fetchData() async {
    final response =
        await http.get(Uri.parse('https://www.homs.com.np/api/dashboard/5'));
    if (response.statusCode == 200) {
      try {
        var jsonData = jsonDecode(response.body);
        var workers = Workers.fromJson(jsonData);
        // print('Parsed Data: $workers');
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
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.workordersAssigned.length,
                  itemBuilder: (context, index) {
                    var workorder = snapshot.data!.workordersAssigned[index];
                    // var workorderpreventive =
                    //     snapshot.data!.recentWorkordersCorrective[index];
                    // var workordercorrective =
                    //     snapshot.data!.recentWorkordersCorrective[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.grey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(workorder.status.toString()),
                                Text(workorder.id.toString()),
                                Text(workorder.priority.toString()),
                                Text(workorder.assignedToId.toString()),
                                Text(workorder.assignedById.toString()),
                                Text(workorder.status.toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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
          }),
    );
  }
}
