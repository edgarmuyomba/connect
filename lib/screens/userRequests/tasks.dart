import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/spinkit.dart';

class tasks extends StatefulWidget {
  const tasks({super.key});

  @override
  State<tasks> createState() => _tasksState();
}

class _tasksState extends State<tasks> {
  var user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 18, 27, 34),
        body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('requests')
                    .where('request', isEqualTo: user!.email)
                    .where('status', whereIn: ['Accepted', 'Rejected'])
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return spinkit;
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, index) {
                        var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                        return Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                                padding: EdgeInsets.all(15),
                                height: 200,
                                width: 200,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                data['request']
                                                    .toString()
                                                    .substring(
                                                        0,
                                                        data['request']
                                                            .toString()
                                                            .indexOf('@')),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255)),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(data['location'],
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(data['details'],
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Text(data['decription'],
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255)))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(children: [
                                      Row(
                                        children: [
                                          Text(data['date'],
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 133, 150, 160)))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(data['time'],
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 133, 150, 160)))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(data['status'],
                                                style: TextStyle(
                                                    color: Colors.blue))
                                          ],
                                        ),
                                      ),
                                    ])
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                )));
                      },
                    );
                  }
                }));
  }
}
