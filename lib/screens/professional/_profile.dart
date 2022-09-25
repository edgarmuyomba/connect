import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
                color: Color.fromARGB(255, 31, 44, 52),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem(
                        value: "Log Out",
                        child: Text(
                          "Log Out",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        onTap: () => FirebaseAuth.instance.signOut(),
                      ),
                    ]),
          ],
        ),
        body: Center(
            child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('uniqueId', isEqualTo: user!.uid)
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshots.hasData) {
              var data = snapshots.data!.docs[0].data() as Map<String, dynamic>;
              return Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/proProfile.png'),
                    radius: 200,
                  ),
                  Row(
                    children: [
                      Text("Firstname: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
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
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(data['lastname'].toString().toUpperCase(),
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
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Email: ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        user!.email!,
                        style: TextStyle(fontSize: 18),
                      ),
                      Icon(Icons.edit),
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
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        data['Profession'].toString().toUpperCase(),
                        style: TextStyle(fontSize: 18),
                      ),
                      Icon(Icons.edit),
                    ],
                  ),
                ],
              );
            } else {
              print('No records found!!!!!!!!!!!!!!!!!!!!');
              return Container();
            }
          },
        )));
  }
}
