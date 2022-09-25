import 'package:connect/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:connect/main.dart';

class loginwidget extends StatefulWidget {
  final VoidCallback isLogin;
  final Function() isPro;

  const loginwidget({
    Key? key,
    required this.isLogin,
    required this.isPro,
  }) : super(key: key);

  @override
  State<loginwidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<loginwidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            FlutterLogo(size: 150),
            SizedBox(height: 20),
            Text('Welcome Back!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Color.fromARGB(255, 0, 65, 118))),
            TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Email'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email.trim())
                      ? 'Enter a valid email'
                      : null,
            ),
            SizedBox(
              height: 4,
            ),
            TextField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              icon: Icon(
                Icons.lock_open,
                size: 32,
              ),
              label: Text(
                'Sign In',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: signIn,
            ),
            SizedBox(
              height: 24,
            ),
            Divider(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black54, fontSize: 17),
                  text: 'SignUp as a ',
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = widget.isPro,
                      text: 'Professional',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    )
                  ]),
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black54, fontSize: 17),
                  text: 'SignUp as a ',
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.isLogin,
                      text: 'User',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ));

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
