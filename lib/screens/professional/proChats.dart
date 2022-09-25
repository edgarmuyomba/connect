import 'package:connect/models/user.dart';
import 'package:connect/screens/professional/proInbox.dart';
import 'package:flutter/material.dart';

class proChat extends StatefulWidget {
  const proChat({super.key});

  @override
  State<proChat> createState() => _proChatState();
}

class _proChatState extends State<proChat> {
  void pushInbox(User pro) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return proInbox(user: pro,);
    }));
  }

  List<Map<String, dynamic>> data = [
    {
      'firstname': 'Male',
      'lastname': 'Simon',
      'email': 'malesimon@gmail.com',
      'Contact': '+256 700 999 999',
    
    },
    {
      'firstname': 'Kavule',
      'lastname': 'Edrine',
      'email': 'kavuleedrine@gmail.com',
      'Contact': '+256 700 999 999',
    },
    {
      'firstname': 'Tumusiime',
      'lastname': 'Deo',
      'email': 'tumudeo234@gmail.com',
      'Contact': '+256 700 999 999',
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
            subtitle: Text('Hi, I would like to make an appointment...'),
            onTap: () => pushInbox(User(data[index]['firstname'] + ' '+ data[index]['lastname'],data[index]['email'], data[index]['Contact'], )),
          ),
        );
      },
    ),
    );   
  }
}
