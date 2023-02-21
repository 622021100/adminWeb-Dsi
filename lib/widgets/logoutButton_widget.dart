import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_admin/login/loginPage.dart';

import '../componants/app_colors.dart';

class LogoutButton extends StatelessWidget {
  LogoutButton({super.key});
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextButton.icon(
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32))),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding:
                          const EdgeInsets.only(top: 35, left: 25, right: 25),
                      contentPadding: const EdgeInsets.only(
                          left: 25, right: 25, top: 20, bottom: 20),
                      buttonPadding: const EdgeInsets.only(
                          left: 25, right: 25, bottom: 35),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22)),
                      title: const Text('ต้องการออกจากระบบใช่ไหม ?'),
                      content: const Text(
                          'หากออกจากระบบแล้ว คุณต้องทำการเข้าสู่ระบบใหม่อีกครั้ง'),
                      actions: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22))),
                          onPressed: () {
                            auth.signOut().then((value) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return const LoginPage();
                              }));
                            });
                          },
                          child: const Text(
                            'ออกจากระบบ',
                            style: TextStyle(color: AppColor.kRed2),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22))),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('ยกเลิก'),
                        ),
                      ],
                    );
                  });
            },
            icon: const FaIcon(
              FontAwesomeIcons.powerOff,
              color: AppColor.nWhite,
              size: 15,
            ),
            label: const Text(
              'ออกจากระบบ',
              style: TextStyle(color: AppColor.nWhite),
            ),
          ),
        ],
      ),
    );
  }
}
