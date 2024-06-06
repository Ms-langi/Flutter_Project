import 'package:flutter/material.dart';

class ProfileIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
      },
      tooltip: 'Profile',
      child: Icon(Icons.person),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(), // Profile picture and user info
            ActivityFeed(), // User's activity feed
            PrivacySettings(), // Privacy settings
            ProfileEditor(), // Profile editing form
            NotificationsSettings(), // Notification settings
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder for profile picture and user info
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/profile_picture.jpg'),
            // Implement logic to allow user to change profile picture
          ),
          SizedBox(height: 16),
          Text(
            'John Doe',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text('john.doe@example.com'),
        ],
      ),
    );
  }
}

class ActivityFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder for activity feed
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Activity Feed',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // Implement logic to display user's activity feed
          Text('Recent activity goes here...'),
        ],
      ),
    );
  }
}

class PrivacySettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder for privacy settings
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Privacy Settings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // Implement privacy settings UI
          Text('Privacy settings go here...'),
        ],
      ),
    );
  }
}

class ProfileEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder for profile editing form
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Edit Profile',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // Implement profile editing form
          Text('Profile editing form goes here...'),
        ],
      ),
    );
  }
}

class NotificationsSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder for notification settings
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notification Settings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // Implement notification settings UI
          Text('Notification settings go here...'),
        ],
      ),
    );
  }
}
