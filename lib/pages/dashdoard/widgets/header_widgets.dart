import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/web_admin/componants/constant.dart';
import 'package:web_admin/web_admin/componants/app_colors.dart';
import 'package:web_admin/pages/dashdoard/widgets/logoutButton_widget.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 35,
            // bottom: 25,
            top: 35,
          ),
          child: Text(
            'WELCOME',
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Spacer(),
        Container(
          margin: const EdgeInsets.only(
            right: 35,
            left: 15,
            top: 35,
          ),
          child: LogoutButton(),
        ),
      ],
    );
  }

  // Widget navigationIcon({icon}) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Icon(
  //       icon,
  //       color: AppColor.kNavy,
  //     ),
  //   );
  // }

  AnimatedContainer animetedSearchBar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: _folded ? 56 : 300,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        color: AppColor.kBlueGrayLite,
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
                        hintStyle: TextStyle(color: AppColor.kGray),
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
                    color: AppColor.kNavy,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
