// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_admin/web_admin/componants/app_colors.dart';
import 'package:web_admin/web_admin/pagesNew/CluesDetailPage.dart';
import 'package:web_admin/web_admin/widgets/header/header_widgets1.dart';
import 'package:web_admin/web_admin/widgets/search/searchBar_widget.dart';

class Clueslistdata extends StatefulWidget {
  const Clueslistdata({Key? key}) : super(key: key);

  @override
  State<Clueslistdata> createState() => _ClueslistdataState();
}

class _ClueslistdataState extends State<Clueslistdata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kAppbar,
      body: SafeArea(
        child: Column(
          children: [
            header(),
            divider(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("cluesdata")
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
                                padding: const EdgeInsets.only(
                                  left: 45,
                                  right: 45,
                                  bottom: 25,
                                ),
                                child: Material(
                                  borderRadius: BorderRadius.circular(32),
                                  color: AppColor.kBlueGrayLite,
                                  child: InkWell(
                                    highlightColor:
                                        AppColor.kNavy1.withOpacity(0.2),
                                    splashColor:
                                        AppColor.kNavy.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(32),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditPage(id: document.id),
                                          )).then((value) => setState(() {}));
                                    },
                                    child: content(document),
                                  ),
                                ),
                              );
                            }).toList(),
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
      ),
    );
  }

  Padding divider() {
    return const Padding(
      padding: EdgeInsets.only(
        left: 55,
        right: 55,
        top: 15,
        bottom: 10,
      ),
      child: Divider(),
    );
  }

  Row header() {
    return Row(
      children: const [
        HeaderWidgets1(),
        Spacer(),
        SearchBarWidget(),
      ],
    );
  }

  SizedBox content(QueryDocumentSnapshot<Object?> document) {
    return SizedBox(
        width: double.infinity,
        height: 115,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
                left: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "คดีความผิดตามกฎหมายว่าด้วย" + document["Type"],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("ผู้แจ้งเบาะแส : " + document["Name"]),
                  const Spacer(),
                  Text(
                    document["Date"] + " | " + document["Time"],
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
            deleteButton(document),
          ],
        ));
  }

  Container deleteButton(QueryDocumentSnapshot<Object?> document) {
    return Container(
      width: 115,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: AppColor.kRed,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          bottomRight: Radius.circular(32),
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
                  title: const Text('ยืนยันการลบข้อมูล ?'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('คุณต้องการลบ '),
                          Text("  ${document["Type"]} ใช่หรือไม่ ?",
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
          FontAwesomeIcons.xmark,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> delete(String? id) {
    return FirebaseFirestore.instance.collection('cluesdata').doc(id).delete();
  }
}
