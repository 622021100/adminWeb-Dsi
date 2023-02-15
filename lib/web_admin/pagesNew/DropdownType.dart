import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_admin/web_admin/componants/app_colors.dart';

class CluesUpdateData extends StatefulWidget {
  const CluesUpdateData({super.key, this.id});
  final String? id;
  @override
  State<CluesUpdateData> createState() => _CluesUpdateDataState();
}

class _CluesUpdateDataState extends State<CluesUpdateData> {
  var selectTypeclues;

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  CollectionReference cluesDB =
      FirebaseFirestore.instance.collection("cluestype");

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(50),
        decoration: BoxDecoration(
          color: AppColor.kAppbar,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Container(
          margin: const EdgeInsets.all(50),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('cluestype')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
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
                      icon: const FaIcon(FontAwesomeIcons.circleChevronDown),
                      onChanged: (selectType) {
                        setState(() {
                          selectTypeclues = selectType;
                        });
                      },
                      value: selectTypeclues,
                      items:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        return DropdownMenuItem(
                            value: document['laws'],
                            child: Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'คดีความผิดตามกฎหมายว่าด้วย' + document['laws'],
                            ));
                      }).toList(),
                    ),
                  );
                }
              }),
        ));
  }
}
