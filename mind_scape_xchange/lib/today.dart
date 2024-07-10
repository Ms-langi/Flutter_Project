import 'package:flutter/material.dart';

class TodayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learning Today'),
      ),
      body: Center(
        child: Text('Lesson Content'),
      ),
    );
  }
}
