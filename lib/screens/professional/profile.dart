import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.professional});

  final professional;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('uniqueId', isEqualTo: widget.professional!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var data = snapshot.data!.docs[0].data() as Map<String, dynamic>;
          return Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/proProfile.png'),
              ),
              Row(
                children: [
                  Text("Firstname: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.professional!.email!,
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(Icons.edit),
                ],
              ),
            ],
          );
        }
      },
    ));
  }
}
