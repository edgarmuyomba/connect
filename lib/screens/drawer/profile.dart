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
                radius: 220,
              ),
              Text(
                'Signed In as',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    'Name: ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Muyomba Matthew Edgar',
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(Icons.edit),
                ],
              ),
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
              Row(
                children: [
                  Text(
                    'Account: ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Ordinary',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
