import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/profilePicture.jpg'),
                radius: 100,
              ),
              Text(
                'Signed In as',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 8,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('uniqueId', isEqualTo: user!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      var data =
                          snapshot.data!.docs[0].data() as Map<String, dynamic>;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Firstname: ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text(data['firstname'].toString().toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 18,
                                  )),
                              Icon(Icons.edit),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              Text("Lastname: ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text(data['lastname'].toString().toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 18,
                                  )),
                              Icon(Icons.edit),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Location: ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                data['Location'].toString().toUpperCase(),
                                style: TextStyle(fontSize: 18),
                              ),
                              Icon(Icons.edit),
                            ],
                          ),
                        ],
                      );
                    }
                  }),
              Row(
                children: [
                  Text(
                    'Email: ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    user!.email!,
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(Icons.edit),
                ],
              ),
            ],
          ),
        ));
  }
}
