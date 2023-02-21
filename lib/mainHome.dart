import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:web_admin/Routes.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  void initState() {
    super.initState();
    Flurorouter.setupRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.prompt().fontFamily),
      initialRoute: "/",
      onGenerateRoute: Flurorouter.router.generator,
    );
  }
}
