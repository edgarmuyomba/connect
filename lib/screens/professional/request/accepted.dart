import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class accepted extends StatelessWidget {
  const accepted({super.key});

  bool validComp(DateTime date) {
    DateTime dt = DateTime.now();
    if (dt.isBefore(date)) {
      return false;
    } else if (dt.isAfter(date)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 18, 27, 34),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('requests')
                .where('uniqueId', isEqualTo: user!.email)
                .where('status', isEqualTo: 'Accepted')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, index) {
                    var data = snapshot.data!.docs[index].data();
                    return Padding(
                        padding: EdgeInsets.all(10),
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
                                                        255, 255, 255, 255)))
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
                                            style:
                                                TextStyle(color: Colors.green))
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          height: 25,
                                          width: 100,
                                          child: ElevatedButton(
                                              child: Text('Completed',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                              onPressed: validComp(
                                                      DateTime.parse(
                                                          data['date'] +
                                                              ' ' +
                                                              data['time']))
                                                  ? () {
                                                      var docRef = FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'requests')
                                                          .doc(data['date']
                                                                  .toString() +
                                                              data['time'
                                                                  .toString()]);
                                                      docRef.update({
                                                        'status': 'Completed'
                                                      });
                                                      var userRef =
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users')
                                                              .doc(user.email);
                                                      userRef.update({
                                                        'complete': FieldValue
                                                            .increment(1)
                                                      });
                                                    }
                                                  : null,
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 2),
                                                  textStyle: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold))))
                                    ],
                                  ),
                                ])
                              ],
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            )));
                  },
                );
              } else {
                return Center(child: Text('No data'));
              }
            }));
  }
}
