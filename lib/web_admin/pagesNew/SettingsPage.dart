import 'package:flutter/material.dart';
import 'package:web_admin/web_admin/componants/app_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.kAppbar,
        child: const Center(
          child: Text('Settings Page...'),
        ),
      ),
    );
  }
}