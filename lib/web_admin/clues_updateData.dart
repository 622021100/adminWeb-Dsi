import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_admin/web_admin/modelDB/cluesModel.dart';
import 'package:web_admin/web_admin/newFloder/common/app_colors.dart';

class CluesUpdateData extends StatefulWidget {
  const CluesUpdateData({super.key, this.id});
  final String? id;
  @override
  State<CluesUpdateData> createState() => _CluesUpdateDataState();
}

class _CluesUpdateDataState extends State<CluesUpdateData> {
  var selectTypeclues;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.kAppbar,
        body: Container(
            margin: const EdgeInsets.all(50),
            decoration: BoxDecoration(
              color: AppColor.kAppbar,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Container(
              margin: const EdgeInsets.all(50),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('cluesdata')
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text('กรุณารอสักครู่...'),
                      );
                    } else {
                      return Expanded(
                        flex: 2,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: 'ประเภทฐานความผิด',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                          isDense: true,
                          iconDisabledColor: AppColor.kBlueGrayLite,
                          iconEnabledColor: AppColor.kNavy,
                          icon: const FaIcon(
                              FontAwesomeIcons.circleChevronDown),
                          onChanged: (selectType) {
                            setState(() {
                              selectTypeclues = selectType;
                            });
                          },
                          value: selectTypeclues,
                          items: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            return DropdownMenuItem(
                                value: document['Type'],
                                child: Text(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  'คดีความผิดตามกฎหมายว่าด้วย' +
                                      document['Type'],
                                ));
                          }).toList(),
                        ),
                      );
                    }
                  }),
              // child: Column(
              //   children: [
              //     TextFormField(
              //       controller: _type,
              //       validator: (value) {
              //         if (value!.isEmpty) {
              //           return 'กรุณาป้อนชื่อไม้มงคลด้วยครับ';
              //         }
              //         return null;
              //       },
              //       decoration: const InputDecoration(
              //         border: OutlineInputBorder(
              //           borderRadius:
              //               BorderRadius.all(Radius.circular(32)),
              //           borderSide: BorderSide(
              //               color: Color(0xff296e48), width: 2),
              //         ),
              //         enabledBorder: OutlineInputBorder(
              //           borderRadius:
              //               BorderRadius.all(Radius.circular(32)),
              //           borderSide: BorderSide(
              //               color: Color(0xff296e48), width: 2),
              //         ),
              //         errorBorder: OutlineInputBorder(
              //           borderRadius:
              //               BorderRadius.all(Radius.circular(32)),
              //           borderSide:
              //               BorderSide(color: Colors.red, width: 2),
              //         ),
              //         prefixIcon: Icon(
              //           Icons.drive_file_rename_outline_outlined,
              //           color: Colors.grey,
              //         ),
              //         label: Text(
              //           'ชื่อไม้มงคล',
              //           style: TextStyle(color: Colors.grey),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            )));
  }
}
            // return const Center(
            //     child: Text(
            //   "กรุณารอสักครู่...",
            //   style: TextStyle(
            //     fontSize: 22,
            //     color: Colors.white,
            //   ),
            // ));