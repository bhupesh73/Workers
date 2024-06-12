import 'package:flutter/material.dart';
import 'package:loginuicolors/worker_login/model/model.dart';

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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                            color: Colors.grey,
            
              child: ListTile(
                title: Text('Workorder ID: ${workorder.id}'),
                subtitle: Text('Status: ${workorder.status}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkAssignedDetailPage(workorder: workorder),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class WorkAssignedDetailPage extends StatelessWidget {
  final RecentWorkordersPreventive workorder;

  const WorkAssignedDetailPage({Key? key, required this.workorder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workorder ID: ${workorder.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: workorder.id == null ? Center(child: Text('Not Found')) : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${workorder.id}'),
            Text('Template ID: ${workorder.woTemplateId}'),
            Text('Scheduled Start Date: ${workorder.scheduledStartDate}'),
            Text('Status: ${workorder.status}'),
            // Add more fields as necessary
          ],
        ),
      ),
    );
  }
}
