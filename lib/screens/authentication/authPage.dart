import 'package:connect/screens/authentication/_login.dart';
import 'package:connect/screens/authentication/_signUp.dart';
import 'package:connect/screens/authentication/login.dart';
import 'package:connect/screens/authentication/ordAcc.dart';
import 'package:connect/screens/authentication/proAcc.dart';
import 'package:connect/screens/authentication/signUp.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  bool isPro = false;
  @override
  Widget build(BuildContext context) {
    if (!isLogin && !isPro) {
      return ordAccount(isLogin: toggle1, isPro: toggle2);
    } else if (isLogin && isPro) {
      return proAccount(isLogin: toggle1, isPro: toggle2);
    } else {
      return loginwidget(isLogin: toggle1, isPro: toggle2);
    }
  } 
      // isLogin
      // ? LoginWidget(onClickedSignUp: toggle1)
      // // : SignUpWidget(onClickedsignIn: toggle);
      // : signUp(onClickedsignIn: toggle1);

  void toggle1() => setState(() => isLogin = !isLogin);
  void toggle2() => setState(() => isPro = !isPro);
}


