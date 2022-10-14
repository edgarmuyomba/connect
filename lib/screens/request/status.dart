import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


// class status extends StatelessWidget {
//   const status({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var user = FirebaseAuth.instance.currentUser;
//     return Scaffold(
//         backgroundColor: Color.fromARGB(255, 18, 27, 34),
//         body: Padding(
//             padding: EdgeInsets.all(10),
//             child: SingleChildScrollView(
//               child: Expanded(
//                   child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Text('Pending Requests',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                   StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection('requests')
//                         // .where('uniqueId', isEqualTo: user!.email)
//                         // .where('status', isEqualTo: 'Pending')
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       // if (snapshot.connectionState != ConnectionState.waiting) {
//                       if (snapshot.hasData) {
//                         return ListView.builder(
//                           itemCount: snapshot.data!.docs.length,
//                           itemBuilder: (BuildContext context, index) {
//                             var data = snapshot.data!.docs[index].data()
//                                 as Map<String, dynamic>;
//                             // return Container(
//                             //     padding: EdgeInsets.all(10),
//                             //     child: Row(
//                             //       children: [
//                             //         Column(
//                             //           children: [
//                             //             Row(
//                             //               children: [
//                             //                 Text(data['request']
//                             //                     .toString()
//                             //                     .substring(
//                             //                         0,
//                             //                         data['request']
//                             //                             .toString()
//                             //                             .indexOf('@')))
//                             //               ],
//                             //             ),
//                             //             Row(
//                             //               children: [Text(data['location'])],
//                             //             ),
//                             //             Row(
//                             //               children: [Text(data['details'])],
//                             //             ),
//                             //             Row(
//                             //               children: [Text(data['description'])],
//                             //             ),
//                             //             Row(
//                             //               children: [
//                             //                 ElevatedButton(
//                             //                     child: Text('Accept'),
//                             //                     onPressed: () {
//                             //                       var docRef = FirebaseFirestore
//                             //                           .instance
//                             //                           .collection('requests')
//                             //                           .doc(data['date']
//                             //                                   .toString() +
//                             //                               data['time'
//                             //                                   .toString()]);
//                             //                       docRef.update(
//                             //                           {'status': 'Accepted'});
//                             //                     },
//                             //                     style: ElevatedButton.styleFrom(
//                             //                         backgroundColor:
//                             //                             Colors.blue,
//                             //                         padding:
//                             //                             EdgeInsets.symmetric(
//                             //                                 horizontal: 50,
//                             //                                 vertical: 20),
//                             //                         textStyle: TextStyle(
//                             //                             fontSize: 30,
//                             //                             fontWeight:
//                             //                                 FontWeight.bold)))
//                             //               ],
//                             //             ),
//                             //           ],
//                             //         ),
//                             //         Column(children: [
//                             //           Row(
//                             //             children: [Text(data['date'])],
//                             //           ),
//                             //           Row(
//                             //             children: [Text(data['time'])],
//                             //           ),
//                             //           Row(
//                             //             children: [Text(data['status'])],
//                             //           ),
//                             //           Row(
//                             //             children: [
//                             //               ElevatedButton(
//                             //                   child: Text('Reject'),
//                             //                   onPressed: () {
//                             //                     var docRef = FirebaseFirestore
//                             //                         .instance
//                             //                         .collection('requests')
//                             //                         .doc(data['date']
//                             //                                 .toString() +
//                             //                             data[
//                             //                                 'time'.toString()]);
//                             //                     docRef.update(
//                             //                         {'status': 'Rejected'});
//                             //                   },
//                             //                   style: ElevatedButton.styleFrom(
//                             //                       backgroundColor: Colors.red,
//                             //                       padding: EdgeInsets.symmetric(
//                             //                           horizontal: 50,
//                             //                           vertical: 20),
//                             //                       textStyle: TextStyle(
//                             //                           fontSize: 30,
//                             //                           fontWeight:
//                             //                               FontWeight.bold)))
//                             //             ],
//                             //           ),
//                             //         ])
//                             //       ],
//                             //     ));
//                             return ListTile(
//                               title: Text(data['recepient']),
//                               subtitle: Text(data['location']),
//                             );
//                           },
//                         );
//                       } else {
//                         return Center(
//                           child: Text('No Pending requests!'),
//                         );
//                       }
//                       // } else {
//                       //   return Center(child: CircularProgressIndicator());
//                       // }
//                     },
//                   ),
//                   Row(
//                     children: [
//                       Text('Accepted Requests',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                   StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection('requests')
//                         // .where('uniqueId', isEqualTo: user.email)
//                         // .where('status', isEqualTo: 'Accepted')
//                         .snapshots(),
//                     builder: ((context, snapshot) {
//                       // if (snapshot.connectionState == ConnectionState.waiting) {
//                       //   return Center(child: CircularProgressIndicator());
//                       // } else {
//                       if (snapshot.hasData) {
//                         return ListView.builder(
//                           itemCount: snapshot.data!.docs.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             var data = snapshot.data!.docs[index].data()
//                                 as Map<String, dynamic>;
//                             // return Container(
//                             //     padding: EdgeInsets.all(10),
//                             //     child: Row(
//                             //       children: [
//                             //         Column(
//                             //           children: [
//                             //             Row(
//                             //               children: [
//                             //                 Text(data['request']
//                             //                     .toString()
//                             //                     .substring(
//                             //                         0,
//                             //                         data['request']
//                             //                             .toString()
//                             //                             .indexOf('@')))
//                             //               ],
//                             //             ),
//                             //             Row(
//                             //               children: [Text(data['location'])],
//                             //             ),
//                             //             Row(
//                             //               children: [Text(data['details'])],
//                             //             ),
//                             //             Row(
//                             //               children: [Text(data['description'])],
//                             //             ),
//                             //           ],
//                             //         ),
//                             //         Column(children: [
//                             //           Row(
//                             //             children: [Text(data['date'])],
//                             //           ),
//                             //           Row(
//                             //             children: [Text(data['time'])],
//                             //           ),
//                             //           Row(
//                             //             children: [Text(data['status'])],
//                             //           ),
//                             //           Row(
//                             //             children: [
//                             //               ElevatedButton(
//                             //                   child: Text('Completed'),
//                             //                   onPressed: () {
//                             //                     var docRef = FirebaseFirestore
//                             //                         .instance
//                             //                         .collection('requests')
//                             //                         .doc(data['date']
//                             //                                 .toString() +
//                             //                             data[
//                             //                                 'time'.toString()]);
//                             //                     docRef.update(
//                             //                         {'status': 'Completed'});
//                             //                     var userRef = FirebaseFirestore
//                             //                         .instance
//                             //                         .collection('users')
//                             //                         .doc(user.email);
//                             //                     userRef.update({
//                             //                       'complete':
//                             //                           FieldValue.increment(1)
//                             //                     });
//                             //                   },
//                             //                   style: ElevatedButton.styleFrom(
//                             //                       backgroundColor: Colors.green,
//                             //                       padding: EdgeInsets.symmetric(
//                             //                           horizontal: 50,
//                             //                           vertical: 20),
//                             //                       textStyle: TextStyle(
//                             //                           fontSize: 30,
//                             //                           fontWeight:
//                             //                               FontWeight.bold)))
//                             //             ],
//                             //           ),
//                             //         ])
//                             //       ],
//                             //     ));
//                             return ListTile(
//                               title: Text(data['recepient']),
//                               subtitle: Text(data['location']),
//                             );
//                           },
//                         );
//                       } else {
//                         return Center(
//                           child: Text('No currently Accepted job requets'),
//                         );
//                       }
//                       // }
//                     }),
//                   )
//                 ],
//               )),
//             )));
//   }
// }

class status extends StatelessWidget {
  const status({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 18, 27, 34),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('requests')
                .where('uniqueId', isEqualTo: user!.email)
                .where('status', isEqualTo: 'Pending')
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
                                      Row(
                                        children: [
                                          SizedBox(
                                              height: 25,
                                              width: 100,
                                              child: ElevatedButton(
                                                  child: Text(
                                                    'Accept',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.normal
                                                      )
                                                    ),
                                                  onPressed: () {
                                                    var docRef =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'requests')
                                                            .doc(data['date']
                                                                    .toString()
                                                                    .trim() +
                                                                data['time'
                                                                    .toString()
                                                                    .trim()]);
                                                    docRef.update(
                                                        {'status': 'Accepted'});
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.blue,
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
                                                TextStyle(color: Colors.blue))
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                              height: 25,
                                              width: 100,
                                              child: ElevatedButton(
                                                  child: Text(
                                                    'Reject',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.normal
                                                      )
                                                    ),
                                                  onPressed: () {
                                                    var docRef =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'requests')
                                                            .doc(data['date']
                                                                    .toString()
                                                                    .trim() +
                                                                data['time'
                                                                    .toString()
                                                                    .trim()]);
                                                    docRef.update(
                                                        {'status': 'Rejected'});
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
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
