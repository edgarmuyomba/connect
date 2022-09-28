import 'package:flutter/material.dart';

import 'login.dart';
import 'ordAcc.dart';
import 'proAcc.dart';

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

  void toggle1() => setState(() => isLogin = !isLogin);
  void toggle2() => setState(() => isPro = !isPro);
}
