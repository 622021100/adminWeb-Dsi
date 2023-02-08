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
        // child: Center(
        //   child: Container(
        //     child: StreamBuilder(
        //       stream: FirebaseFirestore.instance
        //           .collection("cluesdata")
        //           .snapshots(),
        //       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //         if (!snapshot.hasData) {
        //           return const Center(
        //             child: CircularProgressIndicator(),
        //           );
        //         } else {
        //           return ListView(
        //             children: snapshot.data!.docs.map((document) {
        //               return Container(
        //                 padding: const EdgeInsets.only(
        //                     left: 35, right: 35, bottom: 15),
        //                 child: Material(
        //                   borderRadius: BorderRadius.circular(22),
        //                   color: AppColor.kAppbar,
        //                   child: InkWell(
        //                     highlightColor: AppColor.kNavy1.withOpacity(0.2),
        //                     splashColor: AppColor.kNavy.withOpacity(0.2),
        //                     borderRadius: BorderRadius.circular(22),
        //                     onTap: () {
        //                       showDialog(
        //                         context: context,
        //                         builder: (builder) =>
        //                             XenPopupCard(body: Container()),
        //                       );
        //                       // Navigator.push(
        //                       //   context,
        //                       //   MaterialPageRoute(
        //                       //     builder: (context) => CluesDetailPage(clues: cluess[index]),
        //                       //   ),
        //                       // );
        //                     },
        //                     child: SizedBox(
        //                       width: double.infinity,
        //                       height: 125,
        //                       child: Column(
        //                         mainAxisSize: MainAxisSize.min,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           Container(
        //                             margin: const EdgeInsets.only(
        //                               left: 20,
        //                               top: 20,
        //                               right: 20,
        //                             ),
        //                             child: Row(
        //                               children: [
        //                                 Text(
        //                                   document["Type"],
        //                                   style: const TextStyle(
        //                                     fontSize: 18,
        //                                     fontWeight: FontWeight.bold,
        //                                   ),
        //                                 ),
        //                                 const Spacer(),
        //                                 // Text(
        //                                 //   "${model.Date} ${model.Time}",
        //                                 //   style: const TextStyle(fontSize: 12),
        //                                 // ),
        //                               ],
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               );
        //             }).toList(),
        //           );
        //         }
        //       },
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Container mainData() {
    return Container(
      child: Column(
        children: [
          const HeaderWidgets(),
          Container(
            margin: const EdgeInsets.only(
              left: 30,
              right: 30,
              bottom: 25,
              top: 25,
            ),
            child: Row(
              children: const [
                // Text('ยินดีต้อนรับแอดมินสู่...'),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 30,
                left: 30,
                bottom: 30,
              ),
              child: Row(children: [
                Expanded(
                  // flex: 2,
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
                Expanded(
                    child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.kYellow1,
                            borderRadius: BorderRadius.circular(32)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 25),
                        decoration: BoxDecoration(
                            color: AppColor.kBlue1,
                            borderRadius: BorderRadius.circular(32)),
                      ),
                    ),
                  ],
                )),
                Expanded(
                  // flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/dec8.png',
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
