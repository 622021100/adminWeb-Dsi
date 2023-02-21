// ignore_for_file: prefer_interpolation_to_compose_strings
import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_admin/componants/app_colors.dart';

import '../modelDB/cluesdataModel.dart';


class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, this.id});
  final String? id;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final formKey = GlobalKey<FormState>();

  //copy code
  Future<void> _copyToClipboardLocation() async {
    await Clipboard.setData(ClipboardData(text: _location.text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('คัดลอก'),
    ));
  }

  Future<void> _copyToClipboardAddress() async {
    await Clipboard.setData(ClipboardData(text: _address.text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('คัดลอก'),
    ));
  }

  //
  //connect database Model file
  cluesdata cluess = cluesdata(
    Address: '',
    Detaill: '',
    Date: '',
    Name: '',
    Location: '',
    Point: '',
    Phone: '',
    Type: '',
    Time: '',
  );
  final _editFormKey = GlobalKey<FormState>();
  final TextEditingController _note = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  CollectionReference clues =
      FirebaseFirestore.instance.collection('cluesdata');
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.nWhite,
      body: GestureDetector(
        key: _editFormKey,
        child: FutureBuilder<DocumentSnapshot>(
            future: clues.doc(widget.id).get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> doc =
                    snapshot.data?.data() as Map<String, dynamic>;
                _type.text = doc["Type"];
                _address.text = doc["Address"];
                _location.text = doc["Location"];
                return Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                                color: AppColor.nBlue,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(22),
                                  bottomLeft: Radius.circular(22),
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Spacer(),
                                Image.asset(
                                  'assets/images/A.png',
                                  scale: 10,
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'รายละเอียดเบาะแส',
                                      style: TextStyle(
                                        color: AppColor.nWhite,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Image.asset('assets/images/dec6.png'),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: AppColor.nBlueLite,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(22),
                                  bottomRight: Radius.circular(22),
                                )),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 20,
                              ),
                              //เริ่มต้น รายละเอียด
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  header(),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'ประเภทของการกระทำความผิด',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              typeFeild(),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  const FaIcon(
                                                    FontAwesomeIcons.solidFile,
                                                    size: 13,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Text(
                                                    'รายละเอียดเบาะแส',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                      '${'เมื่อวันที่ :' + doc['Date']} เวลา : ' +
                                                          doc['Time'])
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              details(context, doc),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: const [
                                                  FaIcon(
                                                    FontAwesomeIcons
                                                        .locationDot,
                                                    size: 13,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'สถานที่พบเบาะแส',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                decoration: BoxDecoration(
                                                  color: AppColor.nWhite,
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    address(context),
                                                    const Divider(),
                                                    location(context),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              user(context, doc),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              point(context, doc),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              save()
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
            }),
      ),
    );
  }

  Container comment(BuildContext context, Map<String, dynamic> doc) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 175,
      decoration: BoxDecoration(
        color: AppColor.nWhite,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Container(
        margin: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'การพิจารณาเบื้องต้น',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                controller: _type,
                decoration: const InputDecoration(
                    hintText: 'คอมเมนต์ที่นี่...', border: InputBorder.none),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container point(BuildContext context, Map<String, dynamic> doc) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 330,
      decoration: BoxDecoration(
        color: AppColor.nWhite,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Container(
        margin: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ความประสงค์ที่ต้องการให้ DSi ช่วย',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Text(doc['Point'])
          ],
        ),
      ),
    );
  }

  Container user(BuildContext context, Map<String, dynamic> doc) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: AppColor.nWhite,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Container(
        margin: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'รายละเอียดผู้แจ้งเบาะแส',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.solidUser,
                  size: 13,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(doc['Name']),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.mobile,
                  size: 13,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(doc['Phone']),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row location(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, bottom: 5),
              child: Text(
                '*คัดลอกละติจูดและลองติจูด เพื่อนำไปค้นหาใน Google Map',
                style: TextStyle(
                  color: AppColor.kRed,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: TextField(
                  controller: _location,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: IconButton(
                      onPressed: _copyToClipboardLocation,
                      icon: const FaIcon(FontAwesomeIcons.copy),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        // const SizedBox(width: 20),
        Container(
          margin: const EdgeInsets.only(right: 15, bottom: 10),
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  html.window.open(
                      'https://www.google.co.th/maps/@18.3170581,99.3986862,17z?hl=th',
                      "_blank");
                },
                splashRadius: 22,
                iconSize: 50,
                icon: const Image(
                  image: AssetImage('assets/images/map.png'),
                ),
              ),
              const Text(
                'Google Map',
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
        ),
      ],
    );
  }

  Padding address(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextField(
          controller: _address,
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: IconButton(
              onPressed: _copyToClipboardAddress,
              icon: const FaIcon(FontAwesomeIcons.copy),
            ),
          ),
        ),
      ),
    );
  }

  Container details(BuildContext context, Map<String, dynamic> doc) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          color: AppColor.nWhite,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Container(
          margin: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc["Detaill"],
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ));
  }

  Row header() {
    return Row(
      children: [
        const FaIcon(FontAwesomeIcons.solidFolderOpen),
        const SizedBox(
          width: 5,
        ),
        const Text(
          'รายละเอียดเบาะแส',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        cancel()
      ],
    );
  }

  IconButton cancel() {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const FaIcon(FontAwesomeIcons.xmark),
      color: AppColor.kRed,
    );
  }

  Widget save() {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.8,
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
          'Type': _type.text,
        })
        .then((value) => Navigator.pop(context))
        .catchError((error) => print("Failed to update user: $error"));
  }

  SizedBox typeFeild() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        controller: _type,
        decoration: InputDecoration(
          suffixText: 'สามารถแก้ไขได้',
          suffixStyle: const TextStyle(color: AppColor.kRed),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: AppColor.nWhite,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColor.nBlue,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
