import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.pushNamed(context, '/main/home');
    });
    return Scaffold(
      body: Center(
        child: Container(
          child: const Text(
            'กรุณารอสักครู่...',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}
