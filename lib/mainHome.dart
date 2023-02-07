import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_admin/Routes.dart';
import 'package:web_admin/app/config/themes/app_theme.dart';

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
        theme: AppTheme.basic.copyWith(
          textTheme: GoogleFonts.promptTextTheme(Theme.of(context).textTheme)),
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
    );
  }
}
