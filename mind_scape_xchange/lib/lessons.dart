import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LessonsScreen extends StatefulWidget {
  @override
  LessonsScreenState createState() => LessonsScreenState();
}

class LessonsScreenState extends State<LessonsScreen> {
  late Future<List<String>> _imageUrls;

  @override
  void initState() {
    super.initState();
    int currentWeek =
        (DateTime.now().difference(DateTime(2024, 1, 1)).inDays / 7).ceil() %
            52; // Adjustment based on week calculation
    _imageUrls = fetchImagesForWeek(currentWeek);
  }

  Future<List<String>> fetchImagesForWeek(int week) async {
    List<String> imageUrls = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('images')
        .where('week', isEqualTo: week)
        .get();

    for (var doc in querySnapshot.docs) {
      imageUrls.add(doc['url']);
    }

    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learning Today'),
      ),
      body: FutureBuilder<List<String>>(
        future: _imageUrls,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No images found'));
          } else {
            return ImageList(imageUrls: snapshot.data!);
          }
        },
      ),
    );
  }
}

class ImageList extends StatelessWidget {
  final List<String> imageUrls;

  ImageList({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(imageUrls[index]),
        );
      },
    );
  }
}
