import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils.dart';

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
      padding: const EdgeInsets.all(16),
      child: Form(
          key: formKey,
          child: Container(
            height: (MediaQuery.of(context).size.height),
            width: (MediaQuery.of(context).size.width),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('./assets/bg.jpg'))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Container(
                  width: 600,
                  height: 100,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('./assets/logo.png'))),
                ),
                const SizedBox(height: 20),
                const Text('Welcome Back!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Color.fromARGB(255, 52, 121, 177))),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: emailController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Email', labelStyle: TextStyle(color: Colors.grey)),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email.trim())
                          ? 'Enter a valid email'
                          : null,
                ),
                const SizedBox(
                  height: 4,
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(labelText: 'Password', labelStyle: TextStyle(color: Colors.grey)),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  icon: const Icon(
                    Icons.lock_open,
                    size: 32,
                  ),
                  label: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: signIn,
                ),
                const SizedBox(
                  height: 24,
                ),
                const Divider(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                      style:
                          const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
                      text: 'SignUp as a ',
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.isPro,
                          text: 'Professional',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        )
                      ]),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                      style:
                          const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
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
          )));

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
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
