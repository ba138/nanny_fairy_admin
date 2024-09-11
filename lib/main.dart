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
          apiKey: "AIzaSyCBUyZVjnq9IGxH9Zu6ACNRIJXtkfZ2iuQ",
          authDomain: "nanny-fairy.firebaseapp.com",
          databaseURL: "https://nanny-fairy-default-rtdb.firebaseio.com",
          projectId: "nanny-fairy",
          storageBucket: "nanny-fairy.appspot.com",
          messagingSenderId: "788203773735",
          appId: "1:788203773735:web:2b98a971d82f7a71d61302",
          measurementId: "G-R2CHG55HLV"),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xffF8F8F8)),
      home: const MainScreen(),
    );
  }
}
