// ignore_for_file: prefer_const_constructors

import 'package:connect/models/professional.dart';
import 'package:connect/screens/messaging/inbox.dart';
import 'package:flutter/material.dart';

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
      'Profession': 'Tailor',
      'Contact': '+256 700 999 999',
      'Location': 'Wandegeya',
      'image': 'assets/images.jpg'
    },
    {
      'firstname': 'Matovu',
      'lastname': 'Eric',
      'email': 'matovueric@gmail.com',
      'Profession': 'Carpenter',
      'Contact': '+256 700 999 999',
      'Location': 'Kikoni',
      'image': 'assets/images (2).jpg'
    },
    {
      'firstname': 'Kasozi',
      'lastname': 'Mark',
      'email': 'kasozimark@gmail.com',
      'Profession': 'Plumber',
      'Contact': '+256 700 999 999',
      'Location': 'Mukono',
      'image': 'assets/images (3).jpg'
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
                  data[index]['Profession'],
                  data[index]['Contact'],
                  data[index]['Location'],
                  data[index]['image'])),
            ),
          );
        },
      ),
    );
  }
}
