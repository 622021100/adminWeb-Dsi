import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/web_admin/componants/app_colors.dart';
import 'package:web_admin/web_admin/widgets/header/header_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kAppbar,
      body: SafeArea(
        child: Row(
          children: [Expanded(child: mainData())],
        ),
      ),
    );
  }

  Container mainData() {
    return Container(
      child: Column(
        children: [
          const HeaderWidgets(),
          const Padding(
            padding: EdgeInsets.only(
              left: 55,
              right: 55,
              top: 10,
              bottom: 15,
            ),
            child: Divider(),
          ),
          // Container(
          //   margin: const EdgeInsets.only(
          //     left: 30,
          //     right: 30,
          //     bottom: 25,
          //     top: 25,
          //   ),
          //   child: Row(
          //     children: const [
          //       // Text('ยินดีต้อนรับแอดมินสู่...'),
          //     ],
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 30,
                left: 30,
                bottom: 30,
                top: 35,
              ),
              child: Row(children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 25, left: 25),
                    decoration: BoxDecoration(
                        color: AppColor.kBlueGrayLite,
                        borderRadius: BorderRadius.circular(32)),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("cluestype")
                            .orderBy('laws', descending: true)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView(
                              children: snapshot.data!.docs.map((document) {
                                return Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          "คดีความผิดตามกฎหมายว่าด้วย" +
                                              document["laws"],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                // Expanded(
                //     child: Column(
                //   children: [
                //     Expanded(
                //       child: Container(
                //         decoration: BoxDecoration(
                //             color: AppColor.kYellow1,
                //             borderRadius: BorderRadius.circular(32)),
                //       ),
                //     ),
                //     Expanded(
                //       child: Container(
                //         margin: const EdgeInsets.only(top: 25),
                //         decoration: BoxDecoration(
                //             color: AppColor.kBlue1,
                //             borderRadius: BorderRadius.circular(32)),
                //       ),
                //     ),
                //   ],
                // )),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 350,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/dec8.png'),
                                fit: BoxFit.fitHeight)),
                      ),
                      Expanded(
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                            color: AppColor.kYellow,
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
