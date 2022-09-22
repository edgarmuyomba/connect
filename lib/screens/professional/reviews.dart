import 'package:firebase_auth/firebase_auth.dart';
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
      body: ElevatedButton.icon(
                onPressed: () => FirebaseAuth.instance.signOut(),
                label: Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 20),
                ),
                icon: Icon(Icons.power_settings_new),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
              ),
    );
  }
}

