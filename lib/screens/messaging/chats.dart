// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../models/professional.dart';
import 'inbox.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  void pushInbox(Professional pro) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return Inbox(
        professional: pro,
      );
    }));
  }

  List<Map<String, dynamic>> data = [
    {
      'firstname': 'Ntale',
      'lastname': 'John',
      'email': 'ntalejohn25@gmail.com',
      'Category': 'Tailoring',
      'Contact': '+256 700 999 999',
      'Location': 'Wandegeya',
      'image': 'assets/images.jpg',
      'ratings': [1,3,3,4,5,2],
      'cost': 17000,
      'available': false,
      'verified': false,
      'complete': 10
    },
    {
      'firstname': 'Matovu',
      'lastname': 'Eric',
      'email': 'matovueric@gmail.com',
      'Category': 'Woodworking',
      'Contact': '+256 700 999 999',
      'Location': 'Kikoni',
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
      'Category': 'Plumbing and Waterworks',
      'Contact': '+256 700 999 999',
      'Location': 'Mukono',
      'image': 'assets/images (3).jpg',
      'ratings': [4,2,5,3,1],
      'cost': 25000,
      'available': false,
      'verified': false,
      'complete': 10
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 26, 40, 46),
        title: const Text("Chats"),
      ),
      backgroundColor: Color.fromARGB(255, 3, 26, 36),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(20.0)),
            child: ListTile(
              tileColor: Color.fromARGB(255, 3, 26, 36),
              leading: CircleAvatar(
                  backgroundImage: AssetImage(data[index]['image'])),
              title: Text(
                data[index]['firstname'] + ' ' + data[index]['lastname'],
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                'Hello',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () => pushInbox(Professional(
                  data[index]['firstname'] + ' ' + data[index]['lastname'],
                  data[index]['email'],
                  data[index]['Category'],
                  data[index]['Contact'],
                  data[index]['Location'],
                  data[index]['image'],
                  data[index]['ratings'],
                  data[index]['cost'],
                  data[index]['available'],
                  data[index]['verified'],
                  data[index]['complete'])),
            ),
          );
        },
      ),
    );
  }
}
