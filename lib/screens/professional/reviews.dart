import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('reviews').snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) {
                final data = snapshots.data!.docs[index];
                return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(data['content']),
                      subtitle: Text(data['sender']),
                    ));
              });
            }
            return Text('No reviews');
          }),
    );
  }
}
