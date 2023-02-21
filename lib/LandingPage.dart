import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_admin/componants/app_colors.dart';
import 'package:web_admin/pagesNew/ClueslistPage.dart';
import 'package:web_admin/pagesNew/HomePage.dart';
import 'package:web_admin/widgets/logoutButton_widget.dart';


class LandingPage extends StatefulWidget {
  final String page;
  final String extra;
  const LandingPage({super.key, required this.page, required this.extra});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

List<String> pages = [
  'home',
  'data',
];

List<IconData> Icons = [
  FontAwesomeIcons.house,
  FontAwesomeIcons.listUl,
];

class _LandingPageState extends State<LandingPage> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.nWhite,
      body: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColor.nBlue,
                // borderRadius: BorderRadius.only(
                //   topRight: Radius.circular(32),
                //   bottomRight: Radius.circular(32),
                // ),
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 35,
                          right: 25,
                          left: 25,
                          bottom: 45,
                        ),
                        child: Image.asset(
                          'assets/images/A.png',
                          scale: 10,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  // const Spacer(),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: Icons.map((e) {
                      return NavItem(
                        selected:
                            Icons.indexOf(e) == pages.indexOf(widget.extra),
                        icon: e,
                        onTap: () {
                          if (Icons.indexOf(e) == 1) {
                            Navigator.pushNamed(
                                context, "/main/${pages[Icons.indexOf(e)]}");
                          } else {
                            Navigator.pushNamed(
                                context, "/main/${pages[Icons.indexOf(e)]}");
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 215,
                  ),
                  Container(
                    height: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/444444.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 35,
                    ),
                    child: LogoutButton(),
                  ),
                  // const Spacer(),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: IndexedStack(
              index: pages.indexOf(widget.page),
              children: const [
                HomePage(),
                Clueslistdata(),
                // SettingsPage(),
                // HelpPage(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class NavItem extends StatefulWidget {
  final IconData icon;
  final bool selected;
  final Function onTap;
  const NavItem(
      {super.key,
      required this.icon,
      required this.selected,
      required this.onTap});

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  get auth => FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(22),
      onTap: () {
        widget.onTap();
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.only(
          left: 25,
          right: 25,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: widget.selected ? AppColor.nWhite : AppColor.nBlue,
        ),
        duration: const Duration(milliseconds: 375),
        width: double.infinity,
        height: 100,
        child: Icon(
          widget.icon,
          color: widget.selected ? AppColor.nBlue : AppColor.nWhite,
        ),
      ),
    );
  }
}
