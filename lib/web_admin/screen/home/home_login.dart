import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:web_admin/web_admin/login/loginPage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/1.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 2500),
          child: ScreenTypeLayout(
            mobile: buildTabletAndMobile(),
            tablet: buildTabletAndMobile(),
            desktop: buildDesktop(),
          ),
        ),
      ),
      // body: Container(
      //   height: size.height,
      //   width: size.width,
      //   decoration: const BoxDecoration(
      //       image: DecorationImage(
      //           image: AssetImage("assets/images/bg3.png"), fit: BoxFit.cover)),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: const <Widget>[
      //       // CustomAppbar(),
      //       // Body(),
      //       LoginPage(),
      //       Spacer(
      //         flex: 2,
      //       )
      //     ],
      //   ),
      // ),
    );
  }

  Widget buildTabletAndMobile() => const LoginPage();

  Widget buildDesktop() => const LoginPage();
}
