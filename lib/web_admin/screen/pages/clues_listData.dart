// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/web_admin/pagesNew/DropdownType.dart';
import 'package:web_admin/web_admin/componants/app_colors.dart';
import 'package:web_admin/web_admin/modelDB/cluesModel.dart';
import 'package:web_admin/web_admin/widgets/header/header_widgets1.dart';
import 'package:xen_popup_card/xen_card.dart';

class CluesListData extends StatefulWidget {
  const CluesListData({super.key, this.id});
  final String? id;

  @override
  State<CluesListData> createState() => _CluesListDataState();
}

class _CluesListDataState extends State<CluesListData> {
  final formKey = GlobalKey<FormState>();
  cluesdata _cluesdata = cluesdata(
      Type: "",
      Date: "",
      Time: "",
      Location: "",
      Name: "",
      Phone: "",
      Detaill: "",
      Point: "",
      Address: '',
      Note: '');

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kAppbar,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
          const HeaderWidgets1(),
          Container(
            margin: const EdgeInsets.only(
              left: 35,
              right: 30,
              top: 25,
              bottom: 25,
            ),
            child: Row(
              children: const [
                Text('Filter by :'),
              ],
            ),
          ),
          Expanded(
            child: Row(children: [
              Expanded(
                flex: 2,
                child: Center(
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
                        return ListView(
                          children: snapshot.data!.docs.map((document) {
                            return Container(
                              padding: const EdgeInsets.only(
                                  left: 35, right: 35, bottom: 15),
                              child: Material(
                                borderRadius: BorderRadius.circular(32),
                                color: AppColor.kBlueGrayLite,
                                child: InkWell(
                                  highlightColor:
                                      AppColor.kNavy1.withOpacity(0.2),
                                  splashColor: AppColor.kNavy.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(32),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CluesUpdateData(id: document.id),
                                        )).then((value) => setState(() {}));
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (builder) => XenPopupCard(
                                    //           // body:
                                    //           // Column(
                                    //           //   children: [
                                    //           //     Text(document["Type"])
                                    //           //   ],
                                    //           // ),
                                    //           body: GestureDetector(
                                    //             key: _editFormkey,
                                    //             child:
                                    //                 FutureBuilder<
                                    //                         DocumentSnapshot>(
                                    //                     future: cluesDB
                                    //                         .doc(widget.id)
                                    //                         .get(),
                                    //                     builder: (context,
                                    //                         snapshot) {
                                    //                       if (snapshot
                                    //                           .hasData) {
                                    //                         Map<String,
                                    //                                 dynamic>
                                    //                             doc = snapshot
                                    //                                     .data
                                    //                                     ?.data()
                                    //                                 as Map<
                                    //                                     String,
                                    //                                     dynamic>;
                                    //                         _type.text =
                                    //                             doc["Type"];
                                    //                         _date.text =
                                    //                             doc["Date"];
                                    //                         _time.text =
                                    //                             doc["Time"];
                                    //                         _detail.text =
                                    //                             doc["Detaill"];
                                    //                         _location.text =
                                    //                             doc["Location"];
                                    //                         _name.text =
                                    //                             doc["Name"];
                                    //                         _phone.text =
                                    //                             doc["Phone"];
                                    //                         _point.text =
                                    //                             doc["Point"];
                                    //                         return ListView(
                                    //                           children: [
                                    //                             Column(
                                    //                               children: [
                                    //                                 TextFormField(
                                    //                                   controller:
                                    //                                       _type,
                                    //                                   validator:
                                    //                                       (value) {
                                    //                                     if (value!
                                    //                                         .isEmpty) {
                                    //                                       return 'กรุณาป้อนชื่อไม้มงคลด้วยครับ';
                                    //                                     }
                                    //                                     return null;
                                    //                                   },
                                    //                                   decoration:
                                    //                                       const InputDecoration(
                                    //                                     border:
                                    //                                         OutlineInputBorder(
                                    //                                       borderRadius:
                                    //                                           BorderRadius.all(Radius.circular(32)),
                                    //                                       borderSide:
                                    //                                           BorderSide(color: Color(0xff296e48), width: 2),
                                    //                                     ),
                                    //                                     enabledBorder:
                                    //                                         OutlineInputBorder(
                                    //                                       borderRadius:
                                    //                                           BorderRadius.all(Radius.circular(32)),
                                    //                                       borderSide:
                                    //                                           BorderSide(color: Color(0xff296e48), width: 2),
                                    //                                     ),
                                    //                                     errorBorder:
                                    //                                         OutlineInputBorder(
                                    //                                       borderRadius:
                                    //                                           BorderRadius.all(Radius.circular(32)),
                                    //                                       borderSide:
                                    //                                           BorderSide(color: Colors.red, width: 2),
                                    //                                     ),
                                    //                                     prefixIcon:
                                    //                                         Icon(
                                    //                                       Icons.drive_file_rename_outline_outlined,
                                    //                                       color:
                                    //                                           Colors.grey,
                                    //                                     ),
                                    //                                     label:
                                    //                                         Text(
                                    //                                       'ชื่อไม้มงคล',
                                    //                                       style:
                                    //                                           TextStyle(color: Colors.grey),
                                    //                                     ),
                                    //                                   ),
                                    //                                 ),
                                    //                               ],
                                    //                             )
                                    //                           ],
                                    //                         );
                                    //                       }
                                    //                       return const Text(
                                    //                           "กรุณารอสักครู่...");
                                    //                     }),
                                    //           ),
                                    //         ));
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => CluesDetailPage(clues: cluess[index]),
                                    //   ),
                                    // );
                                  },
                                  child: Expanded(
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 100,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                              left: 20,
                                              top: 20,
                                              right: 20,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "คดีความผิดตามกฎหมายว่าด้วย" +
                                                      document["Type"],
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(document["Date"] +
                                                    " " +
                                                    document["Time"])
                                              ],
                                            ),
                                          ),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                              ),
                                              child: Text("ผู้แจ้งเบาะแส : " +
                                                  document["Name"]))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
