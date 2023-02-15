import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_admin/app/config/themes/app_theme.dart';
import 'package:web_admin/mainHome.dart';
import 'package:web_admin/web_admin/login/loginPage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   super.initState();
  //   Flurorouter.setupRouter();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin | NewsClues',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.basic.copyWith(
          textTheme: GoogleFonts.promptTextTheme(Theme.of(context).textTheme)),
      home: const MainHome(),
      // home: const LoginPage(),
    );
  }
}



// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Admin | News Clues',
//       theme: AppTheme.basic.copyWith(
//           textTheme: GoogleFonts.promptTextTheme(Theme.of(context).textTheme)),
//       initialRoute: '/',
//       // scrollBehavior: CustomScrollBehaviour(),
//       home: HomePageNew(),
//     );
//   }
// }

// class CustomScrollBehaviour extends MaterialScrollBehavior {
//   @override
//   Set<PointerDeviceKind> get dragDevices => {
//         PointerDeviceKind.touch,
//         PointerDeviceKind.mouse,
//       };
// }
