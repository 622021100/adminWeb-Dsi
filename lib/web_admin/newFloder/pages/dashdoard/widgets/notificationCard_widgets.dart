import 'package:flutter/cupertino.dart';
import 'package:web_admin/web_admin/newFloder/common/app_colors.dart';

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: AppColor.kYellow,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.kNavy,
                  ),
                  children: [
                    TextSpan(text: "Good Morning"),
                    TextSpan(
                      text: "Ravi Patel",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Today you have 9 New Apllications. \nAlso you need to hire 2 new UX Designers. \nReact Native Developer",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.kNavy,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Read More",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.kNavy,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          const Spacer(),
          Image.asset(
            "assets/images/dec2.png",
            height: 150,
          )
        ],
      ),
    );
  }
}
