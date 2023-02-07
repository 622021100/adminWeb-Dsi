// ignore: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/web_admin/componants/constant.dart';
import 'package:web_admin/web_admin/screen/home/home_login.dart';


class AdminPageMobile extends StatefulWidget {
  const AdminPageMobile({super.key});

  @override
  State<AdminPageMobile> createState() => _AdminPageMobileState();
}

class _AdminPageMobileState extends State<AdminPageMobile> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      elevation: 25,
      child: SizedBox(
        height: 600,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextButton dashboardButton() {
    return TextButton(
      child: const Text(
        "Dashboard",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      onPressed: () {},
    );
  }

  SizedBox exitButton() {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: kButton,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
              side: BorderSide.none,
            )),
        onPressed: () {
          auth.signOut().then((value) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            }));
          });
        },
        child: const Text(
          "ออกจากระบบ",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Text headText() {
    return const Text(
      "จัดการข้อมูลเบาะแสทางการข่าว",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
