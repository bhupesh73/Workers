import 'package:flutter/material.dart';
import 'package:loginuicolors/worker_login/model/model.dart';

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
                      builder: (context) =>
                          WorkCorrectiveDetailPage(workorder: workorder),
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

class WorkCorrectiveDetailPage extends StatelessWidget {
  final RecentWorkordersCorrective workorder;

  const WorkCorrectiveDetailPage({Key? key, required this.workorder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workorder ID: ${workorder.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: workorder.id == null
            ? Center(child: Text('Not Found'))
            : Column(
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
                  // Add more fields as necessary
                ],
              ),
      ),
    );
  }
}
