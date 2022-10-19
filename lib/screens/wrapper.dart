import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/spinkit.dart';

import 'authentication/authPage.dart';
import 'home/homePage.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: spinkit);
              } else if (snapshot.hasError) {
                return Center(child: Text('Something Went Wrong!'));
              } else if (snapshot.hasData) {
                return homePage();
              } else {
                return AuthPage();
              }
            })));
  }
}
