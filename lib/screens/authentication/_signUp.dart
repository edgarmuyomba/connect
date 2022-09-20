import 'package:connect/screens/authentication/proAcc.dart';
import 'package:flutter/material.dart';

class signUp extends StatefulWidget {
  final Function() onClickedsignIn;
  const signUp({super.key, required this.onClickedsignIn});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {

  void pushProAcc(toggle) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return proAccount(isLogin: toggle, isPro: toggle);
    }));
  }

  void pushOrdAcc(toggle) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return proAccount(isLogin: toggle, isPro: toggle);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        SizedBox(height: 150),
        Text('Sign Up As...'),
        ElevatedButton(onPressed: () => pushProAcc(widget.onClickedsignIn), child: Text('Professional')),
        ElevatedButton(onPressed: () => pushOrdAcc(widget.onClickedsignIn), child: Text('User')),
      ],
    )));
  }
}
