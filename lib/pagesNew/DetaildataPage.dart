// ignore_for_file: prefer_interpolation_to_compose_strings
import 'dart:html' as html;
import 'dart:html';
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
      content: Text('คัดลอก หมายเลขลองจิจูดและละติจูด สำเร็จ'),
    ));
  }

  Future<void> _copyToClipboardAddress() async {
    await Clipboard.setData(ClipboardData(text: _address.text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('คัดลอก สถานที่พบเบาะแส สำเร็จ'),
    ));
  }

  Future<void> _copyToClipboardDetails() async {
    await Clipboard.setData(ClipboardData(text: _details.text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('คัดลอก รายละเอียดข้อมูลเบาะแส สำเร็จ'),
    ));
  }

  Future<void> _copyToClipboardPoint() async {
    await Clipboard.setData(ClipboardData(text: _point.text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('คัดลอก ความประสงค์ที่ต้องการให้ DSI ช่วยเหลือ สำเร็จ'),
    ));
  }

  Future<void> _copyToClipboardPhone() async {
    await Clipboard.setData(ClipboardData(text: _phone.text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('คัดลอก เบอร์โทรศัพท์ผู้แจ้งเบาะแส สำเร็จ'),
    ));
  }

  Future<void> _copyToClipboardName() async {
    await Clipboard.setData(ClipboardData(text: _phone.text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('คัดลอก ชื่อผู้แจ้งเบาะแส สำเร็จ'),
    ));
  }

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
  final TextEditingController _type = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _details = TextEditingController();
  final TextEditingController _point = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _name = TextEditingController();

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
                _details.text = doc["Detaill"];
                _point.text = doc["Point"];
                return Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      children: [
                        Expanded(
                          child: typList(),
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
                                vertical: 15,
                              ),
                              //เริ่มต้น รายละเอียด
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  header(context, doc),
                                  Container(
                                    margin: const EdgeInsets.only(top: 30),
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
                                              Row(
                                                children: [
                                                  typeFeild(),
                                                  const SizedBox(width: 5),
                                                  save(),
                                                ],
                                              ),
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
                                                      '${'วันที่พบเบาะแส : ' + doc['Date']}  เวลา : ' +
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
                                                  Spacer(),
                                                  Text(
                                                    '*คัดลอกตำแหน่ง เพื่อนำไปค้นหาใน Google Map',
                                                    style: TextStyle(
                                                      color: AppColor.kRed,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                    decoration: BoxDecoration(
                                                      color: AppColor.nWhite,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              22),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        address(context),
                                                        const Divider(),
                                                        location(context),
                                                      ],
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  mapButton()
                                                ],
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

  SizedBox mapButton() {
    return SizedBox(
      height: 130,
      width: 100,
      child: Material(
        borderRadius: BorderRadius.circular(22),
        color: AppColor.nOrange,
        child: InkWell(
          highlightColor: AppColor.nBlack.withOpacity(0.2),
          splashColor: AppColor.nBlack.withOpacity(0.2),
          borderRadius: BorderRadius.circular(22),
          onTap: () {
            html.window.open(
                'https://www.google.co.th/maps/@18.3170581,99.3986862,17z?hl=th',
                "_blank");
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              FaIcon(
                FontAwesomeIcons.locationDot,
                color: AppColor.nWhite,
              ),
              SizedBox(height: 5),
              Text(
                'Google Map',
                style: TextStyle(
                  color: AppColor.nWhite,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container typList() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.nBlue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          bottomLeft: Radius.circular(22),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("cluestype").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      borderRadius: BorderRadius.circular(12),
                      color: AppColor.nBlueLite.withOpacity(0.2),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "คดีความผิดตาม" + document["laws"],
                            style: const TextStyle(color: AppColor.nWhite),
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
    );
  }

  Container point(BuildContext context, Map<String, dynamic> doc) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 370,
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
              'ความประสงค์ที่ต้องการให้ช่วยเหลือ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            TextField(
              readOnly: true,
              maxLines: 5,
              controller: _point,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                const Spacer(),
                IconButton(
                  onPressed: _copyToClipboardPoint,
                  icon: const FaIcon(FontAwesomeIcons.copy),
                ),
              ],
            ),
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

  Padding location(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 10,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextField(
          readOnly: true,
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
    );
  }

  Padding address(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 15,
        right: 15,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextField(
          readOnly: true,
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
            children: [
              TextField(
                readOnly: true,
                controller: _details,
                maxLines: 6,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  IconButton(
                    onPressed: _copyToClipboardDetails,
                    icon: const FaIcon(FontAwesomeIcons.copy),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row header(BuildContext context, Map<String, dynamic> doc) {
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
        reportView(context, doc),
        cancel()
      ],
    );
  }

  TextButton reportView(BuildContext context, Map<String, dynamic> doc) {
    return TextButton(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32))),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => Dialog(
                    child: SizedBox(
                      height: 1000,
                      width: 500,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.all(35),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ความผิดเกี่ยวกับ' + doc['Type'],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ), 
                              // TextField(
                              //   controller: _type,
                              //   style: const TextStyle(
                              //       fontWeight: FontWeight.bold, fontSize: 18),
                              //   decoration: const InputDecoration(
                              //     border: InputBorder.none,
                              //   ),
                              // ),
                              // TextField(
                              //   readOnly: true,
                              //   controller: _point,
                              //   maxLines: 6,
                              //   decoration: const InputDecoration(
                              //     border: InputBorder.none,
                              //   ),
                              // ),
                              Text('ผู้พบเห็นเบาะแส ' +
                                  doc['Name'] +
                                  ' ' +
                                  doc['Phone'] +
                                  ' พบเบาะแสเมื่อเวลา ' +
                                  doc['Time'] +
                                  ' นาฬิกา' +
                                  ' ของวันที่ ' +
                                  doc['Date'] +
                                  ' ณ บริเวณ ' +
                                  doc['Address'] +
                                  ' (' +
                                  doc['Location'] +
                                  ')' +
                                  ' โดยมีรายละเอียด ดังนี้ คือ' +
                                  doc['Detaill'] +
                                  ' และมีความประสงค์ให้ทางกรมสอบสวนคดีพิเศษเข้าช่วยเหลือ คือ' +
                                  doc['Point'])
                              // Text('พบเบาะแสเมื่อเวลา ' +
                              //     doc['Time'] +
                              //     ' นาฬิกา' +
                              //     ' ของวันที่ ' +
                              //     doc['Date']),
                              // Text('บริเวณ ' +
                              //     doc['Address'] +
                              //     '(' +
                              //     doc['Location'] +
                              //     ')'),
                              // Text('โดยมีรายละเอียด ดังนี้ คือ' +
                              //     doc['Detaill']),
                              // Text(
                              //     'และมีความประสงค์ให้ทางกรมสอบสวนคดีพิเศษเข้าช่วยเหลือ คือ' +
                              //         doc['Point'])
                            ],
                          ),
                        ),
                      ),
                    ),
                  ));
        },
        child: const Text(
          'ดูในรูปแบบสรุปเป็นเอกสาร',
          style: TextStyle(decoration: TextDecoration.underline),
        ));
  }

  IconButton cancel() {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const FaIcon(FontAwesomeIcons.solidCircleXmark),
      color: AppColor.kRed,
    );
  }

  Widget save() {
    return SizedBox(
      height: 55,
      width: 100,
      child: TextButton(
        style: TextButton.styleFrom(
          elevation: 5,
          foregroundColor: Colors.white,
          backgroundColor: AppColor.nBlue,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
        onPressed: () {
          var snackBar =
              const SnackBar(content: Text('บันทึก การแก้ไขเรียบร้อยแล้ว'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
        // .then((value) => Navigator.pop(context))
        .catchError((error) => print("Failed to update user: $error"));
  }

  SizedBox typeFeild() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
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
            borderSide: const BorderSide(
              color: AppColor.nBlue,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
