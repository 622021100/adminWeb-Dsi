import 'package:flutter/material.dart';
import 'package:web_admin/web_admin/pagesNew/CluesPage.dart';
import 'package:web_admin/web_admin/componants/app_colors.dart';
import 'package:web_admin/pages/dashdoard/widgets/header_widgets.dart';
import 'package:web_admin/pages/dashdoard/widgets/notificationCard_widgets.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kNavy,
      body: Container(
        margin: const EdgeInsets.all(10),
        // padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.kGrey,
          borderRadius: BorderRadius.circular(36),
        ),
        child: Column(
          children: [
            const HeaderWidgets(),
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: const [
                          NotificationCardWidget(),
                          SizedBox(height: 5),
                          CluesPage()
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
