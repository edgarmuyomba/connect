import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../maps.dart';
import '../drawer/drawer.dart';
import '../messaging/chats.dart';

class ordHome extends StatefulWidget {
  const ordHome({super.key});

  @override
  State<ordHome> createState() => _ordHome();
}

class _ordHome extends State<ordHome> {
  var _currentPage = 0;
  var user = FirebaseAuth.instance.currentUser;

  var _pages = [
    Drawer_(),
    Chat(),
    MapWidget(),
  ];

  List<Map<String, dynamic>> data = [
    {
      'firstname': 'Ntale',
      'lastname': 'John ',
      'email': 'ntalejohn@gmail.com',
      'Profession': 'Tailor',
      'Contact': '+256 700 934 876',
      'Location': 'Wandegeya',
      'accountType': 'Professional',
      'image': 'assets/images (3).jpg',
    },
    {
      'firstname': 'Matovu',
      'lastname': 'Eric',
      'email': 'matovueric@gmail.com',
      'Profession': 'Carpenter',
      'Contact': '+256 700 912 456',
      'Location': 'Kikoni',
      'accountType': 'Professional',
      'image': 'assets/images (2).jpg',
    },
    {
      'firstname': 'Kasozi',
      'lastname': 'Mark',
      'email': 'kasozimark@gmail.com',
      'Profession': 'Plumber',
      'Contact': '+256 700 012 345',
      'Location': 'Mukono',
      'accountType': 'Professional',
      'image': 'assets/images.jpg'
    },
    {
      'firstname': 'Amanya',
      'lastname': 'Ela',
      'email': 'amanyaela@gmail.com',
      'Profession': 'Tailor',
      'Contact': '+256 700 900 567',
      'Location': 'Kampala',
      'accountType': 'Professional',
      'image': 'assets/images (1).jpg',
    },
    {
      'firstname': 'Nalwoga',
      'lastname': 'Suzan',
      'email': 'nalwogasuzan@gmail.com',
      'Profession': 'Chef',
      'Contact': '+256 700 567 437',
      'Location': 'Zzana',
      'accountType': 'Professional',
      'image': 'assets/download (1).jpg',
    },
    {
      'firstname': 'Kukunda',
      'lastname': 'Angella',
      'email': 'kukundaangella@gmail.com',
      'Profession': 'Electrician',
      'Contact': '+256 700 909 321',
      'Location': 'Seguku',
      'accountType': 'Professional',
      'image': 'assets/download (2).jpg',
    },
    {
      'firstname': 'Kyosaba',
      'lastname': 'Jeane',
      'email': 'kyosabajeane@gmail.com',
      'Profession': 'Tailor',
      'Contact': '+256 700 124 789',
      'Location': 'Nakawa',
      'accountType': 'Professional',
      'image': 'assets/download.jpg'
    },
    {
      'firstname': 'Mubiru',
      'lastname': 'Nicholas',
      'email': 'mubirunicholas@gmail.com',
      'Profession': 'Plumber',
      'Contact': '+256 767 437 143',
      'Location': 'Kyambogo',
      'accountType': 'Professional',
      'image': 'assets/images (1).jpg',
    },
    {
      'firstname': 'Tumusiime',
      'lastname': 'Welch',
      'email': 'tumusiimewelch@gmail.com',
      'Profession': 'Carpenter',
      'Contact': '+256 700 999 454 901',
      'Location': 'Luzira',
      'accountType': 'Professional',
      'image': 'assets/images (2).jpg'
    },
    {
      'firstname': 'Nsiimbi',
      'lastname': 'Dennis',
      'email': 'nsiimbidennis@gmail.com',
      'Profession': 'Electrician',
      'Contact': '+256 700 123 345',
      'Location': 'Kikoni',
      'accountType': 'Professional',
      'image': 'assets/images (3).jpg',
    },
    {
      'firstname': 'Nankya',
      'lastname': 'Tania',
      'email': 'nankyatania@gmail.com',
      'Profession': 'Tailor',
      'Contact': '+256 777 775 332',
      'Location': 'Wandegeya',
      'accountType': 'Professional',
      'image': 'assets/images (1).jpg',
    },
    {
      'firstname': 'Jeanie',
      'lastname': 'K',
      'email': 'jeaniek@gmail.com',
      'Profession': 'Plumber',
      'Contact': '+256 701 567 324',
      'Location': 'Nakawa',
      'accountType': 'Professional',
      'image': 'assets/images (2).jpg',
    }
  ];

  addData() async {
    for (var element in data) {
      FirebaseFirestore.instance.collection('users').add(element);
    }
  }

  @override
  void initState() {
    super.initState();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connect',
      home: Scaffold(
        body: Center(child: _pages.elementAt(_currentPage)),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.email),
              label: 'chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
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
      ),
    );
  }
}
