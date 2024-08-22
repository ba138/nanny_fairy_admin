import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:firebase_core/firebase_core.dart';
import 'package:nanny_fairy_admin/views/main_Screen.dart';

void main() async {
  html.document.title = 'ADMIN-PANEL';
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDRnz6LADaCeEnhRX_hz5SXUyNwOTkSxnc",
          authDomain: "nanny-fairy.firebaseapp.com",
          projectId: "nanny-fairy",
          storageBucket: "nanny-fairy.appspot.com",
          messagingSenderId: "788203773735",
          appId: "1:788203773735:web:2a38c29fdeb0529ad61302"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xffF8F8F8)),
        home: const MainScreen());
  }
}
