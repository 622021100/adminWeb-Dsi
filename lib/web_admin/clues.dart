// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/web_admin/modelDB/cluesModel.dart';
import 'package:web_admin/web_admin/newFloder/common/app_colors.dart';
import 'package:web_admin/web_admin/newFloder/pages/dashdoard/widgets/header_widgets.dart';
import 'package:web_admin/web_admin/newFloder/pages/dashdoard/widgets/header_widgets1.dart';
import 'package:xen_popup_card/xen_card.dart';

class CluesPage extends StatefulWidget {
  const CluesPage({super.key, this.id});
  final String? id;

  @override
  State<CluesPage> createState() => _CluesPageState();
}

class _CluesPageState extends State<CluesPage> {
  final formKey = GlobalKey<FormState>();
  cluesdata _cluesdata = cluesdata(
      Type: "",
      Date: "",
      Time: "",
      Location: "",
      Name: "",
      Phone: "",
      Detaill: "",
      Point: "");

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final _editFormkey = GlobalKey<FormState>();

  final TextEditingController _type = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _detail = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _point = TextEditingController();

  CollectionReference cluesDB =
      FirebaseFirestore.instance.collection("cluesdata");
  List<Widget> widgets = [];
  List<cluesdata> cluess = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    await Firebase.initializeApp().then((value) async {
      FirebaseFirestore.instance
          .collection('cluesdata')
          .orderBy('Date', descending: true)
          .snapshots()
          .listen((event) {
        int index = 0;
        for (var snapshots in event.docs) {
          Map<String, dynamic> map = snapshots.data();
          cluesdata model = cluesdata.fromMap(map);
          cluess.add(model);
          setState(() {
            widgets.add(createWidget(model, index));
          });
          index++;
        }
      });
    });
  }

  Future<void> update() async {
    return FirebaseFirestore.instance
        .collection('cluesdata')
        .doc(widget.id)
        .update({
          'Type': _type.text,
          'Date': _date.text,
          'Time': _detail.text,
          'Detaill': _detail.text,
          'Location': _location.text,
          'Name': _name.text,
          'Phone': _phone.text,
          'Point': _point.text,
        })
        .then((value) => Navigator.pop(context))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Widget createWidget(cluesdata model, int index) =>
      // Center(
      //       child: StreamBuilder(
      //         stream:
      //             FirebaseFirestore.instance.collection("cluesdata").snapshots(),
      //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //           if (!snapshot.hasData) {
      //             return const Center(
      //               child: CircularProgressIndicator(),
      //             );
      //           } else {
      //             return ListView(
      //               children: snapshot.data!.docs.map((document) {
      //                 return Card(
      //                   shape: RoundedRectangleBorder(
      //                     borderRadius:
      //                         BorderRadius.circular(32), // if you need this
      //                   ),
      //                   // color: Color.fromARGB(255, 235, 233, 233),
      //                   child: Center(
      //                     child: Padding(
      //                       padding: const EdgeInsets.all(8.0),
      //                       child: Column(
      //                         children: [
      //                           ListTile(
      //                             onTap: () {
      //                               // var doc;
      //                               // Navigator.push(
      //                               //     context,
      //                               //     MaterialPageRoute(
      //                               //       builder: (context) =>
      //                               //           // EditPage(id: document.id),
      //                               //     )).then((value) => setState(() {}));
      //                             },
      //                             title: Text(
      //                               document["Type"],
      //                               style: const TextStyle(
      //                                 fontSize: 20.0,
      //                                 fontWeight: FontWeight.w500,
      //                                 color: Color(0xff296e48),
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 );
      //               }).toList(),
      //             );
      //           }
      //         },
      //       ),
      //     );
      Container(
        // key: _editFormkey,
        padding: const EdgeInsets.only(left: 45, right: 45, bottom: 15),
        child: Material(
          borderRadius: BorderRadius.circular(32),
          color: AppColor.kBlueGrayLite,
          child: InkWell(
            highlightColor: AppColor.kNavy1.withOpacity(0.2),
            splashColor: AppColor.kNavy.withOpacity(0.2),
            borderRadius: BorderRadius.circular(32),
            onTap: () {
              showDialog(
                context: context,
                builder: (builder) => XenPopupCard(
                    borderRadius: 32,
                    cardBgColor: AppColor.kGrey,
                    body: Container(
                      child: Column(
                        children: [
                          Text(model.Type),
                          Text(model.Detaill),
                          TextFormField(
                            controller: _type,
                            decoration: InputDecoration(
                              fillColor: AppColor.kAppbar,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => CluesDetailPage(clues: cluess[index]),
              //   ),
              // );
            },
            child: SizedBox(
              width: double.infinity,
              height: 115,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      // bottom: 5,
                      left: 20,
                      top: 20,
                      right: 20,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "คดีความผิดตามกฎหมายว่าด้วย : ${model.Type}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "${model.Date} | ${model.Time}",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Text(
                          "ผู้แจ้งเบาะแส : ${model.Name}",
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Row(
                  //   children: [
                  //     const Spacer(),
                  //     InkWell(
                  //       onTap: () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) =>
                  //                     CluesDetailPage(clues: cluess[index])));
                  //       },
                  //       child: Container(
                  //         height: 50,
                  //         width: 100,
                  //         decoration: const BoxDecoration(
                  //           color: AppColor.kNavy,
                  //           borderRadius: BorderRadius.only(
                  //             bottomRight: Radius.circular(20),
                  //             topLeft: Radius.circular(20),
                  //           ),
                  //         ),
                  //         child: const Center(
                  //           child: Text(
                  //             "เพิ่มเติม...",
                  //             style: TextStyle(color: AppColor.kCream),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      );
  //  Ink(
  //       decoration: BoxDecoration(
  //         // color: AppColor.kAppbar,
  //         borderRadius: BorderRadius.circular(22),
  //       ),
  //       child: InkWell(
  //           borderRadius: BorderRadius.circular(20),
  //           highlightColor: AppColor.kNavy,
  //           splashColor: AppColor.kYellow,
  //           onTap: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => CluesDetailPage(clues: cluess[index]),
  //               ),
  //             );
  //           },
  //           child: Container(
  //             width: double.infinity,
  //             height: 125,
  //             margin: const EdgeInsets.only(left: 35, top: 20, right: 35),
  //             decoration: BoxDecoration(
  //               color: AppColor.kAppbar,
  //               borderRadius: BorderRadius.circular(22),
  //             ),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Container(
  //                   margin: const EdgeInsets.only(
  //                     // bottom: 5,
  //                     left: 20,
  //                     top: 20,
  //                     right: 20,
  //                   ),
  //                   child: Row(
  //                     children: [
  //                       Text(
  //                         "คดีความผิดตามกฎหมายว่าด้วย : ${model.Type}",
  //                         style: const TextStyle(
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                       const Spacer(),
  //                       Text(
  //                         "${model.Date} ${model.Time}",
  //                         style: const TextStyle(fontSize: 12),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Container(
  //                   margin: const EdgeInsets.only(left: 20),
  //                   child: Row(
  //                     children: [
  //                       Text(
  //                         "ผู้แจ้งเบาะแส : ${model.Name}",
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 const Spacer(),
  //                 // Row(
  //                 //   children: [
  //                 //     const Spacer(),
  //                 //     InkWell(
  //                 //       onTap: () {
  //                 //         Navigator.push(
  //                 //             context,
  //                 //             MaterialPageRoute(
  //                 //                 builder: (context) =>
  //                 //                     CluesDetailPage(clues: cluess[index])));
  //                 //       },
  //                 //       child: Container(
  //                 //         height: 50,
  //                 //         width: 100,
  //                 //         decoration: const BoxDecoration(
  //                 //           color: AppColor.kNavy,
  //                 //           borderRadius: BorderRadius.only(
  //                 //             bottomRight: Radius.circular(20),
  //                 //             topLeft: Radius.circular(20),
  //                 //           ),
  //                 //         ),
  //                 //         child: const Center(
  //                 //           child: Text(
  //                 //             "เพิ่มเติม...",
  //                 //             style: TextStyle(color: AppColor.kCream),
  //                 //           ),
  //                 //         ),
  //                 //       ),
  //                 //     ),
  //                 //   ],
  //                 // ),
  //               ],
  //             ),
  //           )),
  //     );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kAppbar,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Expanded(child: mainData())],
        ),
      ),
    );
  }

  Container mainData() {
    return Container(
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(20),
      // ),
      child: Column(
        children: [
          const HeaderWidgets1(),
          Container(
            margin: const EdgeInsets.only(
              left: 35,
              right: 30,
              bottom: 25,
              top: 25,
            ),
            child: Row(
              children: const [
                Text('Filter by :'),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: widgets.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: AppColor.kYellow,
                          backgroundColor: AppColor.kCream,
                        ))
                      : ListView(
                          children: widgets,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
