import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_admin/componants/app_colors.dart';
import 'package:web_admin/componants/constant.dart';

class HeaderWidgets extends StatefulWidget {
  const HeaderWidgets({super.key});

  @override
  State<HeaderWidgets> createState() => _HeaderWidgetsState();
}

class _HeaderWidgetsState extends State<HeaderWidgets> {
  bool _folded = true;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const FaIcon(FontAwesomeIcons.solidFlag),
            const SizedBox(
              width: 5,
            ),
            const Text(
              'Admin',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Image.asset(
              'assets/images/dec1.png',
              scale: 12,
            )
          ],
        ),
        const SizedBox(
          height: 35,
        ),
        Container(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: AppColor.kAppbar,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Welcome',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.nOrange),
                            ),
                            Text(
                              'ระบบจัดการข้อมูลเบาะแสทางการข่าว',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Expanded(
                    child: Row(
                  children: [
                    Image.asset('assets/images/555555.png'),
                  ],
                )),
              ],
            )),
      ],
    );
  }
}
