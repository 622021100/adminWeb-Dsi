import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:web_admin/web_admin/screen/pages/admin.dart';
import 'package:web_admin/web_admin/screen/pages/appbar.dart';


class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/2.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 2500),
          child: ScreenTypeLayout(
            mobile: buildTabletAndMobile(),
            tablet: buildTabletAndMobile(),
            desktop: buildDesktop(),
          ),
        ),
      ),
    );
  }

  Widget buildTabletAndMobile() => Column(
        children: [
          Expanded(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                AppBarAdmin(),
                // AppBarMobile(),
                SizedBox(
                  height: 25,
                ),
                // AdminPageMobile(),
                AdminPage(),
              ],
            ),
          ),
        ],
      );

  Widget buildDesktop() => Column(
        children: [
          Expanded(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                AppBarAdmin(),
                SizedBox(
                  height: 25,
                ),
                AdminPage(),
              ],
            ),
          ),
        ],
      );
}
