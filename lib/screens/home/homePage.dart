import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../professional/proHome.dart';
import 'ordHome.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePage();
}

class _homePage extends State<homePage> {
  var user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Connect',
        home: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('identifier',
                    isEqualTo: user!.uid.toString() + 'Professional')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                try {
                  var data =
                      snapshot.data!.docs[0].data() as Map<String, dynamic>;
                  return proHome();
                } on RangeError catch (e) {
                  return ordHome();
                }
              }
            }));
  }
}
