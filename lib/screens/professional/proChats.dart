import 'package:flutter/material.dart';

import '../../models/user.dart';
import 'proInbox.dart';

class proChat extends StatefulWidget {
  const proChat({super.key});

  @override
  State<proChat> createState() => _proChatState();
}

class _proChatState extends State<proChat> {
  void pushInbox(User pro) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return proInbox(
        user: pro,
      );
    }));
  }

  List<Map<String, dynamic>> data = [
    {
      'firstname': 'Male',
      'lastname': 'Simon',
      'email': 'malesimon@gmail.com',
      'Contact': '+256 700 999 999',
      'image': 'assets/images.jpg'
    },
    {
      'firstname': 'Kavule',
      'lastname': 'Edrine',
      'email': 'kavuleedrine@gmail.com',
      'Contact': '+256 700 999 999',
      'image': 'assets/images (2).jpg',
    },
    {
      'firstname': 'Tumusiime',
      'lastname': 'Deo',
      'email': 'tumudeo234@gmail.com',
      'Contact': '+256 700 999 999',
      'image': 'assets/images (3).jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 12, 19, 23),
      appBar: AppBar(
        title: Text("Chats"),
        backgroundColor: Color.fromARGB(255, 31, 44, 52),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Color.fromARGB(255, 31, 44, 52),
            child: ListTile(
              leading: CircleAvatar(
                  backgroundImage: AssetImage(data[index]['image'])),
              title: Text(
                  data[index]['firstname'] + ' ' + data[index]['lastname'],
                  style: TextStyle(color: Colors.white)),
              subtitle: Text('Hi, I would like to make an appointment...',
                  style: TextStyle(color: Color.fromARGB(255, 133, 150, 160))),
              onTap: () => pushInbox(User(
                  data[index]['firstname'] + ' ' + data[index]['lastname'],
                  data[index]['email'],
                  data[index]['Contact'],
                  data[index]['image'])),
            ),
          );
        },
      ),
    );
  }
}
