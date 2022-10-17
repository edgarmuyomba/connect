import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_application_1/models/spinkit.dart';
import 'package:flutter_application_1/screens/professional/biodata.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var user = FirebaseAuth.instance.currentUser;
  final _controller = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        final docUser =
            FirebaseFirestore.instance.collection('users').doc(user!.email);
        if (_controller.value) {
          docUser.update({
            'available': true
          });
        } else {
          docUser.update({
            'available': false
          });
        }
      });
    });
  }

  void pushBioData() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => bioData()));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('uniqueId', isEqualTo: user!.uid)
          .snapshots(),
      builder: (context, snapshots) {
        if (snapshots.connectionState == ConnectionState.waiting) {
          return Center(
            child: spinkit,
          );
        } else if (snapshots.hasData) {
          var data = snapshots.data!.docs[0].data() as Map<String, dynamic>;
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 12, 19, 23),
            appBar: AppBar(
              title: Text("Hello, " + data['firstname'].toString()),
              backgroundColor: Color.fromARGB(255, 31, 44, 52),
              actions: [
                PopupMenuButton(
                    color: Color.fromARGB(255, 31, 44, 52),
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                          PopupMenuItem(
                            value: "Log Out",
                            child: Text(
                              "Log Out",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            onTap: () => FirebaseAuth.instance.signOut(),
                          ),
                        ]),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/profilePicture.jpg'),
                      radius: 100,
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(255, 2, 168, 132)),
                        borderRadius: BorderRadius.all(Radius.circular(150)),
                      ),
                      child: Row(
                        children: [
                          Text("Firstname: ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Text(data['firstname'].toString().toUpperCase(),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 133, 150, 160))),
                          Icon(Icons.edit,
                              color: Color.fromARGB(255, 2, 168, 132)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(255, 2, 168, 132)),
                        borderRadius: BorderRadius.all(Radius.circular(150)),
                      ),
                      child: Row(
                        children: [
                          Text("Lastname: ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Text(data['lastname'].toString().toUpperCase(),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 133, 150, 160))),
                          Icon(Icons.edit,
                              color: Color.fromARGB(255, 2, 168, 132)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(255, 2, 168, 132)),
                        borderRadius: BorderRadius.all(Radius.circular(150)),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Location: ',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            data['Location'].toString().toUpperCase(),
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 133, 150, 160)),
                          ),
                          Icon(Icons.edit,
                              color: Color.fromARGB(255, 2, 168, 132)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(255, 2, 168, 132)),
                        borderRadius: BorderRadius.all(Radius.circular(150)),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Email: ',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            user!.email!,
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 133, 150, 160)),
                          ),
                          Icon(Icons.edit,
                              color: Color.fromARGB(255, 2, 168, 132)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(255, 2, 168, 132)),
                        borderRadius: BorderRadius.all(Radius.circular(150)),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Category: ',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            data['Category'].toString().toUpperCase(),
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 133, 150, 160)),
                          ),
                          Icon(Icons.edit,
                              color: Color.fromARGB(255, 2, 168, 132)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 10,
                      color: Colors.white,
                    ),
                    ElevatedButton(
                        onPressed: pushBioData,
                        child: const Text('Bio-Data'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 31, 44, 52),
                        )),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Toggle Availability: ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        availability(),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text(
                          'Completed jobs: ',
                          style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        Text(data['complete'].toString(), style: TextStyle(color: Colors.green, fontSize: 20),)
                      ]
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          print('No records found!!!!!!!!!!!!!!!!!!!!');
          return Container();
        }
      },
    ));
  }

  Widget availability() {
    return AdvancedSwitch(
      controller: _controller,
      activeColor: Colors.green,
      inactiveColor: Colors.red,
      activeChild: Text('YES'),
      inactiveChild: Text('No'),
      borderRadius: BorderRadius.all(const Radius.circular(15)),
      width: 100,
      height: 30,
      enabled: true,
      disabledOpacity: 0.5,
    );
  }
}
