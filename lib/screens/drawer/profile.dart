import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/spinkit.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Color.fromARGB(255, 44, 51, 51),
        ),
        backgroundColor: Color.fromARGB(255, 57, 91, 100),
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: spinkit,
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
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 165, 201, 202))),
                              Text(data['firstname'].toString().toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 231, 246, 242),
                                  )),
                              Icon(Icons.edit, color: Color.fromARGB(255, 2,168,132 )),
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
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 165, 201, 202))),
                              Text(data['lastname'].toString().toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 231, 246, 242),
                                  )),
                              Icon(Icons.edit, color: Color.fromARGB(255, 2,168,132 )),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                'Location: ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 165, 201, 202),)
                              ),
                              Text(
                                data['Location'].toString().toUpperCase(),
                                style: TextStyle(fontSize: 18,
                                color: Color.fromARGB(255, 231, 246, 242)),
                              ),
                              Icon(Icons.edit, color: Color.fromARGB(255, 2,168,132 )),
                            ],
                          ),
                        ],
                      );
                    }
                  }),
              SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  Text(
                    'Email: ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 165, 201, 202),)
                  ),
                  Text(
                    user.email!,
                    style: TextStyle(fontSize: 18,
                    color: Color.fromARGB(255, 231, 246, 242)),
                  ),
                  Icon(Icons.edit, color: Color.fromARGB(255, 2, 168,132)),
                ],
              ),
            ],
          ),
        ));
  }
}
