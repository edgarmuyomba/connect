import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('About Us'),
      ),
      body: Center(
        child: Column(
          children: [
           new Image.asset("assets/about_us.jpg"),
           Text(
                'This is an application to enable people market themseleves and their work on a simple easy to use platform. With this, they will be able to find market for themselves and also people or ordinary users looking for their specialties will be able to find them here'),
          ],
      ),
      )
    );
  }
}
