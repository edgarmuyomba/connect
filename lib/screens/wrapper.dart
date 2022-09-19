import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/models/professional.dart';
import 'package:connect/screens/authentication/authPage.dart';
import 'package:connect/screens/home/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  Future<Professional> _getProUser(user) async {
    var proUser = await FirebaseFirestore.instance
        .collection('professional')
        .where('uniqueId' == user!.uid) as Map<String, dynamic>;
    return Professional(proUser['firstname'] +' '+ proUser['lastname'], proUser['email'], proUser['Profession'], proUser['Contact'], proUser['Location']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Something Horribly Went Wrong!'));
              } else if (snapshot.hasData) {
                return homePage();
              } else {
                return AuthPage();
              }
            })));
  }
}
