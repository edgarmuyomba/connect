import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  var user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
        backgroundColor: Color.fromARGB(255, 31, 44, 52),
      ),
      backgroundColor: Color.fromARGB(255, 12, 19, 23),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('reviews')
              .where('uniqueId', isEqualTo: user!.email)
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;
                    return Card(
                        color: Color.fromARGB(255, 31, 44, 52),
                        child: ListTile(
                          title: Text(data['content'],
                              style: TextStyle(color: Colors.white)),
                          subtitle: Text(data['sender'],
                              style: TextStyle(
                                  color: Color.fromARGB(255, 2, 168, 132))),
                        ));
                  });
            }
            return Center(child: Text('No reviews'));
          }),
    );
  }
}
