// ignore: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/web_admin/componants/constant.dart';
import 'package:web_admin/web_admin/login/loginPage.dart';

class AppBarAdmin extends StatefulWidget {
  const AppBarAdmin({super.key});

  @override
  State<AppBarAdmin> createState() => _AppBarAdminState();
}

class _AppBarAdminState extends State<AppBarAdmin> {
  final auth = FirebaseAuth.instance;
  TextEditingController textController = TextEditingController();
  bool _folded = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/logo2.png",
                    scale: 7,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  dashboardButton(),
                  const SizedBox(width: 15),
                  animetedSearchBar(),
                  const SizedBox(width: 15),
                  exitButton(),
                  const Text("Admin")
                  // admin()
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  ListTile admin() {
    return const ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Admin'),
                );
  }

  AnimatedContainer animetedSearchBar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: _folded ? 56 : 400,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        color: kBlueGrayLite,
        boxShadow: kElevationToShadow[1],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 16),
              child: !_folded
                  ? const TextField(
                      decoration: InputDecoration(
                        hintText: 'ค้นหา เช่น ประเภทคดี',
                        hintStyle: TextStyle(color: Colors.blueGrey),
                        border: InputBorder.none,
                      ),
                    )
                  : null,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_folded ? 36 : 0),
                    topRight: const Radius.circular(36),
                    bottomLeft: Radius.circular(_folded ? 36 : 0),
                    bottomRight: const Radius.circular(36)),
                onTap: (() {
                  setState(() {
                    _folded = !_folded;
                  });
                }),
                child: Padding(
                  padding: const EdgeInsets.all(appPadding),
                  child: Icon(
                    _folded ? Icons.search : Icons.close,
                    color: kButtonNew,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // SizedBox logoutButton() {
  //   return SizedBox(
  //     height: 50,
  //     width: 160,
  //     child: TextButton.icon(
  //       style: ButtonStyle(
  //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //           RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(36),
  //             side: BorderSide.none,
  //           ),
  //         ),
  //         backgroundColor: MaterialStateProperty.all(Colors.red),
  //       ),
  //       onPressed: () {},
  //       icon: Image.asset(
  //         'assets/images/power-off1.png',
  //       ),
  //       label: const Text(
  //         'ออกจากระบบ',
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontSize: 16,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  SizedBox searchBar() {
    return SizedBox(
      width: 300,
      child: TextField(
        onChanged: (textEntered) {},
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                )),
            filled: true,
            fillColor: kBlueGrayLite,
            hintText: "Search",
            hintStyle: const TextStyle(color: Colors.grey),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            )),
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
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
              side: BorderSide.none,
            )),
        onPressed: () {
          auth.signOut().then((value) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const LoginPage();
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

  // TextButton headText() {
  //   return TextButton(
  //     onPressed: () {},
  //     child: const Text(
  //       'NEWS CLUES',
  //       style: TextStyle(
  //         fontSize: 35,
  //         fontWeight: FontWeight.w500,
  //         color: Color(0xFF224480),
  //       ),
  //     ),
  //   );
  // }
}
