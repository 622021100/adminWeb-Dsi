// ignore: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/web_admin/componants/constant.dart';
import 'package:web_admin/web_admin/screen/home/home_login.dart';


class AppBarMobile extends StatefulWidget {
  const AppBarMobile({super.key});

  @override
  State<AppBarMobile> createState() => _AppBarMobileState();
}

class _AppBarMobileState extends State<AppBarMobile> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Image.asset(
                  //       "assets/images/logo2.png",
                  //       scale: 35,
                  //     ),
                  //     const SizedBox(width: 10),
                  //     headText(),
                  //   ],
                  // ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      dashboardButton(),
                      const SizedBox(width: 10),
                      exitButton(),
                    ],
                  ),
                ],
              ),
              // Card(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(36),
              //   ),
              //   elevation: 25,
              //   child: SizedBox(
              //       width: 2500,
              //       height: 600,
              //       child: Center(
              //         child: Padding(
              //           padding: const EdgeInsets.all(15),
              //           child: Column(
              //             children: [
              //               Container(
              //                 margin: const EdgeInsets.symmetric(
              //                     vertical: 25, horizontal: 25),
              //                 child: Row(
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.spaceAround,
              //                   children: [],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       )),
              // )
            ]),
      ),
    );
  }

  TextButton dashboardButton() {
    return TextButton(
      child: const Text(
        "Dashboard",
        style: TextStyle(color: Color(0xFF224480), fontSize: 16),
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
            backgroundColor: kbuttonExit,
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

  TextButton headText() {
    return TextButton(
      onPressed: () {},
      child: const Text(
        'NEWS CLUES',
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.w500,
          color: Color(0xFF224480),
        ),
      ),
    );
  }
}
