// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_admin/web_admin/componants/app_colors.dart';
import 'package:web_admin/web_admin/modelDB/cluesModel.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key, this.id}) : super(key: key);
  final String? id;
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final formKey = GlobalKey<FormState>();
  cluesdata cluess = cluesdata(
      Address: '',
      Detaill: '',
      Date: '',
      Name: '',
      Location: '',
      Note: '',
      Point: '',
      Phone: '',
      Type: '',
      Time: '');
  //เตรียม firebase
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final _editFormKey = GlobalKey<FormState>();

  final TextEditingController _note = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _point = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _detail = TextEditingController();

  CollectionReference clues =
      FirebaseFirestore.instance.collection('cluesdata');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kAppbar,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        key: _editFormKey,
        child: FutureBuilder<DocumentSnapshot>(
          future: clues.doc(widget.id).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> doc =
                  snapshot.data?.data() as Map<String, dynamic>;
              _type.text = doc["Type"];
              _detail.text = doc["Detaill"];
              _date.text = doc["Date"];
              _time.text = doc["Time"];
              _address.text = doc["Address"];
              _location.text = doc["Location"];
              _name.text = doc["Name"];
              _phone.text = doc["Phone"];
              _point.text = doc["Point"];
              _note.text = doc["Note"];
              return Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColor.kTextNew,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headerDetails(),
                      Expanded(
                        child: Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'ประเภทของการกระทำความผิด',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    typeFeild(),
                                    detail(context, doc),
                                    location(context, doc)
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                  color: AppColor.kCream,
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      nameAndphone(context, doc),
                                      point(context, doc),
                                      const Spacer(),
                                      comment(context)
                                    ],
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: Text(
                'กรุณารอสักครู่...',
                style: TextStyle(fontSize: 22),
              ),
            );
          },
        ),
      ),
    );
  }

  Column comment(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            color: AppColor.kTextcolor,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColor.kAppbar,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      bottomRight: Radius.circular(22)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text('การพิจารณาเบื่องต้นของเจ้าหน้าที่'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'แสดงความเห็นที่นี่.....',
                      hintStyle: TextStyle(color: AppColor.kGrey1)),
                  controller: _note,
                  onSaved: (Note) {
                    cluess.Note = Note!;
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Column point(BuildContext context, Map<String, dynamic> doc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ความประสงค์ที่ต้องการให้ DSi ช่วยเหลือ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              color: AppColor.kAppbar, borderRadius: BorderRadius.circular(22)),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(doc["Point"]),
          ),
        ),
      ],
    );
  }

  Column nameAndphone(BuildContext context, Map<String, dynamic> doc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ผู้แจ้งเบาะแส',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              color: AppColor.kAppbar, borderRadius: BorderRadius.circular(22)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(doc['Name']),
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(
                      color: AppColor.kNavy3,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(22),
                          bottomRight: Radius.circular(22)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Text(
                          doc["Phone"],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Column location(BuildContext context, Map<String, dynamic> doc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'สถานที่พบเบาะแส',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            color: AppColor.kAppbar,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                      color: AppColor.kCream,
                      borderRadius: BorderRadius.circular(22)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(doc["Address"]),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          color: AppColor.kCream,
                          borderRadius: BorderRadius.circular(22)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextField(
                          controller: _location,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Link(
                        target: LinkTarget.blank,
                        uri: Uri.parse(
                            'https://www.google.co.th/maps/@18.3170581,99.3986862,17z?hl=th'),
                        builder: (context, followLink) => ElevatedButton(
                            onPressed: followLink,
                            child: const Text('Google Map')),
                      ),
                    ),
                    // InkWell(
                    //     child: const Text('Open Browser'),
                    //     onTap: () => launchUrl(
                    //         Uri.parse('https://www.google.co.th/maps'))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column detail(BuildContext context, Map<String, dynamic> doc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'รายละเอียดเบาะแส',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            color: AppColor.kAppbar,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(doc["Detaill"]),
              ),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColor.kGrey2,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(22),
                        topLeft: Radius.circular(22),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text("เมื่อวันที่ : " +
                          doc["Date"] +
                          " เวลา : " +
                          doc["Time"]),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  TextFormField typeFeild() {
    return TextFormField(
      controller: _type,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
          borderSide: BorderSide(color: Color(0xff296e48), width: 2),
        ),
      ),
    );
  }

  Column headerDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'รายละเอียดของเบาะแส',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            save(),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          height: 15,
        ),
      ],
    );
  }

  Widget save() {
    return SizedBox(
      height: 50,
      width: 100,
      child: TextButton(
        style: TextButton.styleFrom(
          elevation: 5,
          foregroundColor: Colors.white,
          backgroundColor: AppColor.kNavy,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32))),
        ),
        onPressed: () {
          update();
        },
        child: const Text('บันทึก'),
      ),
    );
  }

  Future<void> update() async {
    return FirebaseFirestore.instance
        .collection('cluesdata')
        .doc(widget.id)
        .update({
          'Name': _name.text,
          'Type': _type.text,
          'Time': _time.text,
          'Note': _name.text,
        })
        .then((value) => Navigator.pop(context))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
