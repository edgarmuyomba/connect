import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/drawer/profile.dart';
import 'package:flutter_application_1/screens/home/proList.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 31, 44, 52),
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
              Expanded(child: SizedBox(
                height: 300,
              ),),
              
              ElevatedButton.icon(
                onPressed: () => FirebaseAuth.instance.signOut(),
                label: Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 20),
                ),
                icon: Icon(Icons.power_settings_new, color: Color.fromARGB(255, 2, 168, 132),),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  backgroundColor: Color.fromARGB(255, 44, 51, 51)
                ),
              ),
            ],
          ),
        ),
        body: proList());
  }
}
