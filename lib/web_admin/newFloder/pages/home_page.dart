import 'package:flutter/material.dart';
import 'package:web_admin/web_admin/clues.dart';
import 'package:web_admin/web_admin/clues_listData.dart';
import 'package:web_admin/web_admin/newFloder/common/app_colors.dart';
import 'package:web_admin/web_admin/newFloder/pages/wigets/side_bar.dart';

class HomePageNew extends StatefulWidget {
  const HomePageNew({super.key});

  @override
  State<HomePageNew> createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kNavy,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            //side Navigation bar
            Expanded(
              child: SidebarPage(),
            ),
            //main body part
            Expanded(
              flex: 5,
              child: CluesListData(),
            ),
          ],
        ),
      ),
    );
  }
}
