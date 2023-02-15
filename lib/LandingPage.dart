import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_admin/web_admin/pagesNew/ClueslistPage.dart';
import 'package:web_admin/web_admin/pagesNew/HomePage.dart';
import 'package:web_admin/web_admin/componants/app_colors.dart';
import 'web_admin/widgets/logoutButton_widget.dart';

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
  FontAwesomeIcons.solidFolder,
  FontAwesomeIcons.house,
];

class _LandingPageState extends State<LandingPage> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kAppbar,
      body: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 25,
                          right: 25,
                          left: 25,
                        ),
                        child: Image.asset(
                          'assets/images/logo3-1.png',
                          scale: 30,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
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
                                context, "/main/extra/${pages[Icons.indexOf(e)]}");
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 35,
                      right: 35,
                      bottom: 5,
                    ),
                    child: LogoutButton(),
                  ),
                  const Spacer(),
                  Container(
                    height: 150,
                    decoration: const BoxDecoration(
                      // color: AppColor.kNavy,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(32),
                      ),
                      image: DecorationImage(
                          image: AssetImage('assets/images/dec4.png'),
                          fit: BoxFit.cover),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: IndexedStack(
              index: pages.indexOf(widget.page),
              children: const [
                Clueslistdata(),
                HomePage(),
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
          color: widget.selected ? AppColor.kNavy : Colors.white,
        ),
        duration: const Duration(milliseconds: 375),
        width: double.infinity,
        height: 100,
        child: Icon(
          widget.icon,
          color: widget.selected ? Colors.white : AppColor.kNavy,
        ),
      ),
    );
  }
}
