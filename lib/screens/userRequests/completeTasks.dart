import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/spinkit.dart';

class compTasks extends StatefulWidget {
  const compTasks({super.key});

  @override
  State<compTasks> createState() => _compTasksState();
}

class _compTasksState extends State<compTasks> {

  var user = FirebaseAuth.instance.currentUser;

  final _textController = TextEditingController();

  Future<void> _addReview(String recepient, String uniqueId) async {
    final user = FirebaseAuth.instance.currentUser;
    await showModalBottomSheet(
        backgroundColor: Color.fromARGB(255, 57, 91, 100),
        isScrollControlled: false,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  style: TextStyle(color: Color.fromARGB(255, 165, 201, 202)),
                  controller: _textController,
                  decoration: const InputDecoration(
                      labelText: 'Review',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 231, 246, 242))),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 44, 51, 51)),
                  child: const Text(
                    "Post",
                  ),
                  onPressed: () async {
                    final String text = _textController.text;
                    if (text != null) {
                      await FirebaseFirestore.instance
                          .collection('requests')
                          .where('request', isEqualTo: user!.email)
                          .where('status', isEqualTo: 'Completed')
                          .snapshots();
                      await FirebaseFirestore.instance
                          .collection('reviews')
                          .add({
                        "content": text,
                        "uniqueId": uniqueId,
                        "sender": user.email
                            .toString()
                            .substring(0, user.email.toString().indexOf('@')),
                        "receipient": recepient,
                      });
                      _textController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 18, 27, 34),
        body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('requests')
                    .where('request', isEqualTo: user!.email)
                    .where('status', isEqualTo: 'Completed')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return spinkit;
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, index) {
                        var data = snapshot.data!.docs[index].data();
                        return Padding(
                            padding: EdgeInsets.all(10),
                            child: GestureDetector(
                              child: Container(
                                  padding: EdgeInsets.all(15),
                                  height: 200,
                                  width: 200,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  data['request']
                                                      .toString()
                                                      .substring(
                                                          0,
                                                          data['request']
                                                              .toString()
                                                              .indexOf('@')),
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(data['location'],
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255)))
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(data['details'],
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255)))
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Text(data['decription'],
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255)))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(children: [
                                        Row(
                                          children: [
                                            Text(data['date'],
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 133, 150, 160)))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(data['time'],
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 133, 150, 160)))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text(data['status'],
                                                  style: TextStyle(
                                                      color: Colors.blue))
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                height: 25,
                                                width: 100,
                                                child: ElevatedButton(
                                                    child: Text('Add review',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight
                                                                .normal)),
                                                    onPressed: () => _addReview(data['recepient'], data['uniqueId']),
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.green,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal: 5,
                                                                    vertical: 2),
                                                            textStyle: TextStyle(
                                                                fontSize: 30,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))))
                                          ],
                                        ),
                                      ])
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            // onTap: () => _addReview(data['recepient'], data['uniqueId']),
                            ));
                      },
                    );
                  }
                }));
  }
}
