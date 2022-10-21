import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final messengerKey = GlobalKey<ScaffoldMessengerState>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: messengerKey,
      title: 'Connect',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 31, 44, 52),
        accentColor: Color.fromARGB(255, 2, 168, 132)
      ),
      home: Wrapper(),
    );
  }
}
