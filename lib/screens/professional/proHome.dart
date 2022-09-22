import 'package:connect/screens/professional/proChats.dart';
import 'package:connect/screens/professional/reviews.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '_profile.dart';
import 'package:flutter/material.dart';

class proHome extends StatefulWidget {
  const proHome({super.key});

  @override
  State<proHome> createState() => _proHomeState();
}

class _proHomeState extends State<proHome> {
  var _currentPage = 1;

  var _pages = [
    Reviews(),
    Profile(),
    proChat(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages.elementAt(_currentPage)),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.reviews),
            label: 'Reviews',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
        ],
        currentIndex: _currentPage,
        fixedColor: Colors.blue,
        onTap: (int inIndex) {
          setState(() {
            _currentPage = inIndex;
          });
        },
      ),
    );
  }
}
