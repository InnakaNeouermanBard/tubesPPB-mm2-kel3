import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kas_kontrakan/firebase_options.dart';
import 'package:kas_kontrakan/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kas Kontrakan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color.fromARGB(255, 76, 145, 201),
        focusColor: const Color(0XFFFFECAA),
        hoverColor: const Color.fromARGB(255, 76, 145, 201),
        scaffoldBackgroundColor: const Color(0XFFFCFCFC),
      ),
      home: SplashScreen(),
    );
  }
}
