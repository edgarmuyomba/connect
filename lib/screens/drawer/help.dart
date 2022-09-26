import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri _email =
        Uri.parse('mailto:support@group18.com?subject=%20&body=%20');

    Future<void> _sendEmail() async {
      if (!await launchUrl(_email)) {
        throw 'Could not launch $_email';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              new Image.asset("assets/support-img.png"),
              Text('Experiencing some difficulties?'),
              RichText(
                text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = _sendEmail,
                  text: 'Contact Us',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
