import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    // MapWidget(),
    Text("Coming soon")
  ];

  List<Map<String, dynamic>> data = [
    {
      'firstname': 'Ntale',
      'lastname': 'John ',
      'email': 'ntalejohn@gmail.com',
      'Category': 'Tailoring',
      'Contact': '+256 700 934 876',
      'Location': 'Wandegeya',
      'accountType': 'Professional',
      'image': 'assets/images (3).jpg',
      'ratings': [4,2,5,3,1],
      'cost': 25000,
      'available': false,
      'verified': false,
      'complete': 10
    },
    {
      'firstname': 'Matovu',
      'lastname': 'Eric',
      'email': 'matovueric@gmail.com',
      'Category': 'Woodworking',
      'Contact': '+256 700 912 456',
      'Location': 'Kikoni',
      'accountType': 'Professional',
      'image': 'assets/images (2).jpg',
      'ratings': [5,4,5,3],
      'cost': 25000,
      'available': true,
      'verified': true,
      'complete': 25
    },
    {
      'firstname': 'Kasozi',
      'lastname': 'Mark',
      'email': 'kasozimark@gmail.com',
      'Category': 'Plumbing & Waterworks',
      'Contact': '+256 700 012 345',
      'Location': 'Mukono',
      'accountType': 'Professional',
      'image': 'assets/images.jpg',
      'ratings': [4,2,5,3,1],
      'cost': 25000,
      'available': false,
      'verified': false,
      'complete': 10
    },
    {
      'firstname': 'Amanya',
      'lastname': 'Ela',
      'email': 'amanyaela@gmail.com',
      'Category': 'Tailoring',
      'Contact': '+256 700 900 567',
      'Location': 'Kampala',
      'accountType': 'Professional',
      'image': 'assets/images (1).jpg',
      'ratings': [4,2,5,3,1],
      'cost': 25000,
      'available': true,
      'verified': true,
      'complete': 25
    },
    {
      'firstname': 'Nalwoga',
      'lastname': 'Suzan',
      'email': 'nalwogasuzan@gmail.com',
      'Category': 'Food & Nutrition',
      'Contact': '+256 700 567 437',
      'Location': 'Zzana',
      'accountType': 'Professional',
      'image': 'assets/download (1).jpg',
      'ratings': [5,4,5,3],
      'cost': 25000,
      'available': false,
      'verified': false,
      'complete': 10
    },
    {
      'firstname': 'Kukunda',
      'lastname': 'Angella',
      'email': 'kukundaangella@gmail.com',
      'Category': 'Electricians & Electrical Works',
      'Contact': '+256 700 909 321',
      'Location': 'Seguku',
      'accountType': 'Professional',
      'image': 'assets/download (2).jpg',
      'ratings': [5,4,5,3],
      'cost': 25000,
      'available': true,
      'verified': true,
      'complete': 25
    },
    {
      'firstname': 'Kyosaba',
      'lastname': 'Jeane',
      'email': 'kyosabajeane@gmail.com',
      'Category': 'Tailoring',
      'Contact': '+256 700 124 789',
      'Location': 'Nakawa',
      'accountType': 'Professional',
      'image': 'assets/download.jpg',
      'ratings': [4,2,5,3,1],
      'cost': 25000,
      'available': false,
      'verified': false,
      'complete': 10
    },
    {
      'firstname': 'Mubiru',
      'lastname': 'Nicholas',
      'email': 'mubirunicholas@gmail.com',
      'Category': 'Plumbing & Waterworks',
      'Contact': '+256 767 437 143',
      'Location': 'Kyambogo',
      'accountType': 'Professional',
      'image': 'assets/images (1).jpg',
      'ratings': [1,3,3,4,5,2],
      'cost': 17000,
      'available': true,
      'verified': true,
      'complete': 25
    },
    {
      'firstname': 'Tumusiime',
      'lastname': 'Welch',
      'email': 'tumusiimewelch@gmail.com',
      'Category': 'Woodworking',
      'Contact': '+256 700 999 454 901',
      'Location': 'Luzira',
      'accountType': 'Professional',
      'image': 'assets/images (2).jpg',
      'ratings': [1,3,3,4,5,2],
      'cost': 17000,
      'available': false,
      'verified': false,
      'complete': 10
    },
    {
      'firstname': 'Nsiimbi',
      'lastname': 'Dennis',
      'email': 'nsiimbidennis@gmail.com',
      'Category': 'Electricians & Electrical Works',
      'Contact': '+256 700 123 345',
      'Location': 'Kikoni',
      'accountType': 'Professional',
      'image': 'assets/images (3).jpg',
      'ratings': [1,3,3,4,5,2],
      'cost': 17000,
      'available': true,
      'verified': true,
      'complete': 25
    },
    {
      'firstname': 'Nankya',
      'lastname': 'Tania',
      'email': 'nankyatania@gmail.com',
      'Category': 'Tailoring',
      'Contact': '+256 777 775 332',
      'Location': 'Wandegeya',
      'accountType': 'Professional',
      'image': 'assets/images (1).jpg',
      'ratings': [4,2,5,3,1],
      'cost': 25000,
      'available': false,
      'verified': false,
      'complete': 10
    },
    {
      'firstname': 'Jeanie',
      'lastname': 'K',
      'email': 'jeaniek@gmail.com',
      'Category': 'Plumbing & Waterworks',
      'Contact': '+256 701 567 324',
      'Location': 'Nakawa',
      'accountType': 'Professional',
      'image': 'assets/images (2).jpg',
      'ratings': [1,3,3,4,5,2],
      'cost': 17000,
      'available': true,
      'verified': true,
      'complete': 25
    }
  ];

  // addData() async {
  //   for (var element in data) {
  //     FirebaseFirestore.instance.collection('users').add(element);
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   // addData();
  // }

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
