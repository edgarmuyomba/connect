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
      return Inbox(professional: pro,);
    }));
  }

  List<Map<String, dynamic>> data = [
    {
      'firstname': 'Ntale',
      'lastname': 'John',
      'email': 'ntalejohn25@gmail.com',
      'Profession': 'Tailor',
      'Contact': '+256 700 999 999',
      'Location': 'Wandegeya'
    },
    {
      'firstname': 'Matovu',
      'lastname': 'Eric',
      'email': 'matovueric@gmail.com',
      'Profession': 'Carpenter',
      'Contact': '+256 700 999 999',
      'Location': 'Kikoni'
    },
    {
      'firstname': 'Kasozi',
      'lastname': 'Mark',
      'email': 'kasozimark@gmail.com',
      'Profession': 'Plumber',
      'Contact': '+256 700 999 999',
      'Location': 'Mukono'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
      ),
      body: ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
                backgroundImage: AssetImage('assets/proProfile.png')),
            title: Text(data[index]['firstname'] +' '+data[index]['lastname']),
            subtitle: Text('Hello'),
            onTap: () => pushInbox(Professional(data[index]['firstname'] + ' '+ data[index]['lastname'],data[index]['email'], data[index]['Profession'], data[index]['Contact'], data[index]['Location'])),
          ),
        );
      },
    ),
    );

    
  }
}
