import 'package:flutter/material.dart';

class Share extends StatelessWidget {
  const Share({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Share'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Name:'),
              Text('Contact'),
              Text('Location'),
            ],
          ),
        ),
      );
  }
}
