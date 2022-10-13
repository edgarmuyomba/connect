import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const generatepage());
}

class generatepage extends StatelessWidget {
  const generatepage({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: const Text("SCAN QR CODE")),
          body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('uniqueId', isEqualTo: user!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            var data = snapshot.data!.docs[0].data()
                                as Map<String, dynamic>;
                            return Center(
                              child: QrImage(
                                  data: 'firstname: ' +
                                      data['firstname'].toString() +
                                      '\n'
                                          'lastname : ' +
                                      data['lastname'].toString() +
                                      '\n'
                                          'email: ' +
                                      data['email'].toString() +
                                      '\n'
                                          'Category : ' +
                                      data['Category'] +
                                      '\n'
                                          'Contact : ' +
                                      data['Contact'] +
                                      '\n'
                                          'Location: ' +
                                      data['Location'] +
                                      '\n',
                                  version: QrVersions.auto,
                                  size: (200),
                                  gapless: false,
                                  errorStateBuilder: (cxt, err) {
                                    return Container(
                                      child: const Center(
                                        child: Text(
                                          'Something Went Wrong',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          }
                        }),
                  ])),
            ]),
          ),
        ));
  }
}
