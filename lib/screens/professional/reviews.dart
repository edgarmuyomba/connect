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
      appBar: AppBar(
        title: Text('Reviews'),
        backgroundColor: Color.fromARGB(255, 31, 44, 52),
      ),
      backgroundColor: Color.fromARGB(255, 12, 19, 23),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('reviews').snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) {
                final data = snapshots.data!.docs[index];
                return Card(
                    color: Color.fromARGB(255, 31, 44, 52),
                    child: ListTile(
                      title: Text(data['content'], style: TextStyle(color: Colors.white)),
                      subtitle: Text(data['sender'], style: TextStyle(color: Color.fromARGB(255, 2, 168, 132))),
                    ));
              });
            }
            return Text('No reviews');
          }),
    );
  }
}
