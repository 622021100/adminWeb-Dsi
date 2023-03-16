import 'dart:html';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_admin/login/loginPage.dart';
import 'package:web_admin/pagesNew/ListdataPage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //  await Firebase.initializeApp();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyC6Ci2oQlr_qvYtjv-H_6_2e601RqUBbzI",
            authDomain: "maincluesnew.firebaseapp.com",
            projectId: "maincluesnew",
            storageBucket: "maincluesnew.appspot.com",
            messagingSenderId: "505522768608",
            appId: "1:505522768608:web:9c25acb8d09b623a1e5e85",
            measurementId: "G-S2YPSZ3RZ3"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin | News Clues',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.prompt().fontFamily),
      home: const LoginPage(),
      // home: const ListdataPage(),
    );
  }
}
