import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('About Us'),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20.0), 
            child: Text('Developed by Group18 developers Inc')
            ),
        ),
      );
  }
}
