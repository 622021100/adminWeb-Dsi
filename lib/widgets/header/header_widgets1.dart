import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HeaderWidgets1 extends StatefulWidget {
  const HeaderWidgets1({super.key});

  @override
  State<HeaderWidgets1> createState() => _HeaderWidgets1State();
}

class _HeaderWidgets1State extends State<HeaderWidgets1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const FaIcon(FontAwesomeIcons.list),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'รายการข้อมูลการแจ้งเบาะแสทางการข่าว',
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
      ],
    );
  }
}
