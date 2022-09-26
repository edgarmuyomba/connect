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
    return Center(
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
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 12, 19, 23),
            appBar: AppBar(
              title: Text("Hello, "+ data['firstname'].toString()),
              backgroundColor: Color.fromARGB(255, 31, 44, 52),
              actions: [
                PopupMenuButton(
                    color: Color.fromARGB(255, 31, 44, 52),
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                          PopupMenuItem(
                            value: "Log Out",
                            child: Text(
                              "Log Out",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            onTap: () => FirebaseAuth.instance.signOut(),
                          ),
                        ]),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/profilePicture.jpg'),
                    radius: 100,
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 2, 168, 132)),
                      borderRadius: BorderRadius.all(Radius.circular(150)),
                    ),
                    child: Row(
                      children: [
                        Text("Firstname: ",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Text(data['firstname'].toString().toUpperCase(),
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 133, 150, 160))),
                        Icon(Icons.edit,
                            color: Color.fromARGB(255, 2, 168, 132)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 2, 168, 132)),
                      borderRadius: BorderRadius.all(Radius.circular(150)),
                    ),
                    child: Row(
                      children: [
                        Text("Lastname: ",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Text(data['lastname'].toString().toUpperCase(),
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 133, 150, 160))),
                        Icon(Icons.edit,
                            color: Color.fromARGB(255, 2, 168, 132)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 2, 168, 132)),
                      borderRadius: BorderRadius.all(Radius.circular(150)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Location: ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          data['Location'].toString().toUpperCase(),
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 133, 150, 160)),
                        ),
                        Icon(Icons.edit,
                            color: Color.fromARGB(255, 2, 168, 132)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 2, 168, 132)),
                      borderRadius: BorderRadius.all(Radius.circular(150)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Email: ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          user!.email!,
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 133, 150, 160)),
                        ),
                        Icon(Icons.edit,
                            color: Color.fromARGB(255, 2, 168, 132)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 2, 168, 132)),
                      borderRadius: BorderRadius.all(Radius.circular(150)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Location: ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          data['Profession'].toString().toUpperCase(),
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 133, 150, 160)),
                        ),
                        Icon(Icons.edit,
                            color: Color.fromARGB(255, 2, 168, 132)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          print('No records found!!!!!!!!!!!!!!!!!!!!');
          return Container();
        }
      },
    ));
  }
}
