// ignore_for_file: prefer_interpolation_to_compose_strings
import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_admin/componants/app_colors.dart';
import 'package:web_admin/pagesNew/CluesdetailPage.dart';
import 'package:web_admin/widgets/header/header_widgets1.dart';

class Clueslistdata extends StatefulWidget {
  const Clueslistdata({Key? key}) : super(key: key);

  @override
  State<Clueslistdata> createState() => _ClueslistdataState();
}

class _ClueslistdataState extends State<Clueslistdata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.nWhite,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(child: mainData()),
          ],
        ),
      ),
    );
  }

  Container mainData() {
    return Container(
      margin: const EdgeInsets.only(
        left: 35,
        right: 35,
        top: 35,
      ),
      child: Column(
        children: [
          const HeaderWidgets1(),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("cluesdata")
                        .orderBy("Date", descending: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 25),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColor.nOrange,
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 8,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                left: 20,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Text('รายการข้อมูลเบาะแส')
                                                ],
                                              ),
                                            ),
                                          ),
                                          const VerticalDivider(
                                            thickness: 5,
                                            color: AppColor.nWhite,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: const [
                                                Text('ลบข้อมูล')
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 25,
                                      ),
                                      child: ListView(
                                        children:
                                            snapshot.data!.docs.map((document) {
                                          return Container(
                                            padding: const EdgeInsets.only(
                                              bottom: 18,
                                            ),
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              color: AppColor.nGreyLite,
                                              child: InkWell(
                                                highlightColor: AppColor.nBlack
                                                    .withOpacity(0.2),
                                                splashColor: AppColor.nBlack
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(22),
                                                onTap: () {
                                                  Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetailsPage(
                                                                    id: document
                                                                        .id),
                                                          ))
                                                      .then((value) =>
                                                          setState(() {}));
                                                },
                                                child: content(document),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 25, top: 25, bottom: 25),
                                decoration: BoxDecoration(
                                  color: AppColor.nBlue,
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("cluestype")
                                        .orderBy('laws', descending: true)
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        return ListView(
                                          children: snapshot.data!.docs
                                              .map((document) {
                                            return Container(
                                              margin: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(22),
                                                color: Colors.white,
                                              ),
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(
                                                      "คดีความผิดตาม" +
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
                            )
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row content(QueryDocumentSnapshot<Object?> document) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
              width: double.infinity,
              height: 110,
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 20,
                        bottom: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.solidFolder,
                                size: 13,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "คดีความผิดตาม" + document["Type"],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.user,
                                size: 13,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text("ผู้แจ้งเบาะแส : " + document["Name"]),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.clock,
                                size: 13,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                document["Date"] + " | " + document["Time"],
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: deleteButton(document)),
                ],
              )),
        ),
      ],
    );
  }

  Container deleteButton(QueryDocumentSnapshot<Object?> document) {
    return Container(
      width: 109,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: AppColor.kRed,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),
      ),
      child: IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  titlePadding:
                      const EdgeInsets.only(top: 35, left: 25, right: 25),
                  contentPadding: const EdgeInsets.only(
                      left: 25, right: 25, top: 20, bottom: 20),
                  buttonPadding:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 35),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22)),
                  title: const Text('ยืนยันการลบข้อมูล'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('คุณต้องการลบ '),
                          Text(" ${document["Type"]} ใช่หรือไม่ ?",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Text("หากลบแล้วไม่สามารถกู้คืนได้",
                          style: TextStyle(color: AppColor.kRed))
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22))),
                      onPressed: () {
                        Navigator.pop(context);
                        delete(document.id);
                      },
                      child: const Text(
                        'ลบ',
                        style: TextStyle(color: AppColor.kRed2),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('ยกเลิก'),
                    ),
                  ],
                );
              });
        },
        icon: const FaIcon(
          FontAwesomeIcons.trash,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> delete(String? id) {
    return FirebaseFirestore.instance.collection('cluesdata').doc(id).delete();
  }
}
