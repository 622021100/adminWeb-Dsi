import 'package:flutter/material.dart';
import 'package:web_admin/web_admin/componants/constant.dart';
import 'package:web_admin/web_admin/componants/app_colors.dart';
import 'package:web_admin/pages/dashdoard/widgets/logoutButton_widget.dart';

class HeaderWidgets1 extends StatefulWidget {
  const HeaderWidgets1({super.key});

  @override
  State<HeaderWidgets1> createState() => _HeaderWidgets1State();
}

class _HeaderWidgets1State extends State<HeaderWidgets1> {
  bool _folded = true;

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
            'ข้อมูลการแจ้งเบาะแสทางการข่าว',
            style: TextStyle(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        const Spacer(),
        //  Container(
        //   margin: const EdgeInsets.only(top: 35),
        //   child: animetedSearchBar(),
        // ),
        Container(
          margin: const EdgeInsets.only(
            top: 35,
            right: 35,
            left: 15,
          ),
          child: LogoutButton(),
        ),
        // const Spacer(),
        // animetedSearchBar(),
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
