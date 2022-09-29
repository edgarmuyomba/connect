import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/professional.dart';
import '../messaging/inbox.dart';
import '../messaging/proProfile.dart';
import '../professional/_profile.dart';
import 'share.dart';
import 'help.dart';
import 'about.dart';

class Drawer_ extends StatefulWidget {
  const Drawer_({super.key});

  @override
  State<Drawer_> createState() => _Drawer();
}

class _Drawer extends State<Drawer_> {
  String name = '';
  void pushProfile() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return Profile();
    }));
  }

  void pushShare() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return Share();
    }));
  }

  void pushHelp() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return Help();
    }));
  }

  void pushAbout() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return About();
    }));
  }

  void pushInbox(Professional pro) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return Inbox(
        professional: pro,
      );
    }));
  }

  void pushproProfile(Professional pro) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return proProfile(professional: pro);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Card(
              child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          )),
          actions: [
            PopupMenuButton(
                color: Color.fromARGB(255, 31, 44, 52),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem(
                        value: "Apply Filters",
                        child: Text(
                          "Apply Filters",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ]),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Color.fromARGB(255, 18, 27, 34),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        image: AssetImage("assets/handshake.png"),
                        fit: BoxFit.cover)),
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Connect',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 2, 168, 132),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 2, 168, 132),
                ),
                title: Text('Profile', style: TextStyle(color: Colors.white)),
                onTap: () => {
                  pushProfile(),
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.share,
                  color: Color.fromARGB(255, 2, 168, 132),
                ),
                title: Text('Share', style: TextStyle(color: Colors.white)),
                onTap: () => {
                  pushShare(),
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.help,
                  color: Color.fromARGB(255, 2, 168, 132),
                ),
                title: Text('Help', style: TextStyle(color: Colors.white)),
                onTap: () => {
                  pushHelp(),
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: Color.fromARGB(255, 2, 168, 132),
                ),
                title: Text('About Us', style: TextStyle(color: Colors.white)),
                onTap: () => {
                  pushAbout(),
                },
              ),
              Divider(),
              SizedBox(
                height: 300,
              ),
              ElevatedButton.icon(
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
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('accountType', isEqualTo: 'Professional')
              .snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;

                      if (name.isEmpty) {
                        return Card(
                            child: ListTile(
                          title: Text(
                              data['firstname'] + ' ' + data['lastname'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(data['image']),
                          ),
                          subtitle: Text(
                              data['Profession'] + ' in ' + data['Location']),
                          onTap: () => pushproProfile(Professional(
                              data['firstname'] + ' ' + data['lastname'],
                              data['email'],
                              data['Profession'],
                              data['Contact'],
                              data['Location'],
                              data['image'])),
                        ));
                      }
                      if (data['firstname']
                              .toString()
                              .toLowerCase()
                              .contains(name.toLowerCase()) ||
                          data['Profession']
                              .toString()
                              .toLowerCase()
                              .contains(name.toLowerCase()) ||
                          data['lastname']
                              .toString()
                              .toLowerCase()
                              .contains(name.toLowerCase())) {
                        return Card(
                            child: ListTile(
                          title: Text(
                              data['firstname'] + ' ' + data['lastname'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/proProfile.png'),
                          ),
                          subtitle: Text(
                              data['Profession'] + ' in ' + data['Location']),
                          onTap: () => pushInbox(Professional(
                              data['firstname'] + data['lastname'],
                              data['email'],
                              data['Profession'],
                              data['Contact'],
                              data['Location'],
                              data['image'])),
                        ));
                      }
                      return Container();
                    });
          },
        ));
  }
}
