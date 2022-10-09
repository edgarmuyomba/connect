import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class bioData extends StatefulWidget {
  const bioData({super.key});

  @override
  State<bioData> createState() => _bioDataState();
}

class _bioDataState extends State<bioData> {
  final user = FirebaseAuth.instance.currentUser;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final aboutController = TextEditingController();

  @override
  void dispose() {
    aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 12, 19, 23),
        appBar: AppBar(
          title: const Text('Bio-Data'),
          backgroundColor: Color.fromARGB(255, 31, 44, 52),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('bioData')
                  .where('uniqueId', isEqualTo: user!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  try {
                    var data =
                        snapshot.data!.docs[0].data() as Map<String, dynamic>;
                    return Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text('About',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        tileColor: Color.fromARGB(255, 31, 44, 52),
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                              child: Text(data['about'].toString(), style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 133, 150, 160)),))),
                    ]);
                  } catch (e) {
                    print(e);
                    return Form(
                        key: formKey,
                        child: Column(children: [
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            title: Text('About',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            trailing: Icon(
                              Icons.add_circle,
                              color: Color.fromARGB(255, 2, 168, 132),
                            ),
                            tileColor: Color.fromARGB(255, 31, 44, 52),
                          ),
                          TextFormField(
                              controller: aboutController,
                              cursorColor: Colors.white,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  fillColor: Colors.white, filled: true),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please write something about yourself!';
                                }
                                return null;
                              }),
                          
                          ElevatedButton(
                              onPressed: _saveBio, child: const Text('Save'))
                        ]));
                  }
                }
              }),
        ));
  }

  Future _saveBio() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    await FirebaseFirestore.instance.collection('bioData').add({
      'uniqueId': user!.uid,
      'about': aboutController.text.trim(),
    });
  }
}
