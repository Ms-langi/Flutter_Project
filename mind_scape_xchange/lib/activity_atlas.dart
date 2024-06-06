import 'package:flutter/material.dart';

class ActivityAtlasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Atlas'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Subcategory 1: To Do List
            ExpansionTile(
              title: Text(
                'Action Items',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color.fromARGB(255, 180, 98, 169),
                ),
              ),
              children: [
                Card(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.fiber_manual_record,
                            color: Colors.purple),
                        title: Text(
                          todoList[index],
                          style: TextStyle(
                              color: Color.fromARGB(255, 85, 176, 199)),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16), // Add space between lists
            // Subcategory 2: Completed Activities
            ExpansionTile(
              title: Text(
                'Completed Activities',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color.fromARGB(255, 180, 98, 169),
                ),
              ),
              children: [
                Card(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: completedActivities.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.check_circle, color: Colors.purple),
                        title: Text(
                          completedActivities[index],
                          style: TextStyle(
                              color: Color.fromARGB(255, 85, 176, 199)),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Sample data for demonstration
  final List<String> todoList = [
    'Task 1',
    'Task 2',
    'Task 3',
    // Add more tasks as needed
  ];

  final List<String> completedActivities = [
    'Activity 1',
    'Activity 2',
    'Activity 3',
    // Add more completed activities as needed
  ];
}
