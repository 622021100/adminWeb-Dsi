import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/web_admin/pagesNew/CluesPage.dart';
import 'package:web_admin/web_admin/login/loginPage.dart';
import 'package:web_admin/web_admin/componants/app_colors.dart';

class SidebarPage extends StatefulWidget {
  const SidebarPage({super.key});

  @override
  State<SidebarPage> createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: AppColor.kNavy,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(Icons.delete_rounded),
              //   tooltip: "ลบข้อมูล",
              // )
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 35,
                ),
                child: Image.asset(
                  'assets/images/logo3.png',
                  height: 55,
                ),
                // child: const Text(
                //   "News Clues.",
                //   style: TextStyle(
                //       color: AppColor.kYellow,
                //       fontSize: 45,
                //       fontWeight: FontWeight.bold),
                // ),
              ),
              DrawerListTile(
                title: "ข้อมูลการแจ้งเบาะแสทางการข่าว",
                press: () {},
                icon: 'assets/images/clues.png',
              ),
              DrawerListTile(
                title: "รายงานทางสถิติ",
                press: () {},
                icon: 'assets/images/dashboard.png',
              ),
              DrawerListTile(
                title: "ตั้งค่าอื่น ๆ",
                press: () {},
                icon: 'assets/images/settings.png',
              ),
              // TaskMenu(onSelected: (int index, String label) {}),
              const Spacer(),
              logoutButton(context),
              // exitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Container logoutButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: DrawerListTile(
        title: "ออกจากระบบ",
        press: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  titlePadding:
                      const EdgeInsets.only(top: 35, left: 25, right: 25),
                  contentPadding: const EdgeInsets.only(
                      left: 25, right: 25, top: 20, bottom: 20),
                  buttonPadding:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 35),
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
                      child: const Text('ออกจากระบบ'),
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
        icon: 'assets/images/logout.png',
      ),
    );
  }

  Container exitButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: SizedBox(
        width: 300,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.kRed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
                side: BorderSide.none,
              )),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('ต้องการออกจากระบบใช่ไหม ?'),
                    content: const Text(
                        'หากออกจากระบบแล้ว ต้องทำการเข้าสู่ระบบใหม่อีกครั้ง'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {},
                        child: const Text('ออกจากระบบ'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('ยกเลิก'),
                      ),
                    ],
                  );
                });
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
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String title, icon;
  final VoidCallback press;
  const DrawerListTile(
      {super.key,
      required this.title,
      required this.press,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Image.asset(
        icon,
        color: AppColor.kGrey,
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: AppColor.kGrey),
      ),
    );
  }
}
