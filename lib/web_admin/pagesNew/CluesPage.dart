import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_admin/web_admin/modelDB/cluesModel.dart';
import 'package:web_admin/web_admin/componants/app_colors.dart';
import 'package:web_admin/web_admin/widgets/header/header_widgets1.dart';
import 'package:xen_popup_card/xen_card.dart';

class CluesPage extends StatefulWidget {
  const CluesPage({super.key, this.id});
  final String? id;

  @override
  State<CluesPage> createState() => _CluesPageState();
}

class _CluesPageState extends State<CluesPage> {
  TextEditingController _note = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  cluesdata clues = cluesdata(
      Type: '',
      Date: '',
      Time: '',
      Location: '',
      Name: '',
      Phone: '',
      Detaill: '',
      Point: '',
      Address: '',
      Note: '');

  CollectionReference cluesDB =
      FirebaseFirestore.instance.collection("cluesdata");
  List<Widget> widgets = [];
  List<cluesdata> cluess = [];
  String? selectTypeset;

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

  Widget createWidget(cluesdata model, int index) => Container(
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
                    cardBgColor: Colors.white,
                    body: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          header(),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      typelaws(model),
                                      details(model),
                                      location(model),
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
                                          nameAndPhone(model),
                                          point(model),
                                          const Spacer(),
                                          noteText(),
                                          // note(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              );
            },
            child: listData(model),
          ),
        ),
      );

  Column noteText() {
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
              TextFormField(
                controller: _note,
                onSaved: (Note) {
                  clues.Note = Note!;
                },
              )
              // const Padding(
              //   padding: EdgeInsets.all(15),
              //   child: TextField(
              //     controller: _note,
              //     keyboardType: TextInputType.multiline,
              //     maxLines: 5,
              //     minLines: 1,
              //     decoration: InputDecoration(
              //         border: InputBorder.none,
              //         hintText: 'แสดงความเห็นที่นี่.....',
              //         hintStyle: TextStyle(color: AppColor.kGrey1)),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Column point(cluesdata model) {
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
            child: Text(model.Point),
          ),
        ),
      ],
    );
  }

  Column typelaws(cluesdata model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ประเภทของการกระทำความผิด',
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
                child: Text('คดีความผิดตามกฎหมายว่าด้วย : ${model.Type}'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column nameAndPhone(cluesdata model) {
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
                child: Text(model.Name),
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
                          model.Phone,
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

  Column header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'รายละเอียดข้อมูลเบาะแส',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            // reportButton(),
            // const SizedBox(
            //   width: 15,
            // ),
            saveButton(),
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

  SizedBox saveButton() {
    return SizedBox(
      height: 50,
      width: 100,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          elevation: 5,
          foregroundColor: Colors.white,
          backgroundColor: AppColor.kNavy,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32))),
        ),
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
                  title: const Text('ยืนยัน'),
                  content: const Text(
                      'ต้องการบันทึกการแก้ไขข้อมูลเบาะแสนี้ใช่ไหม ?'),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22))),
                      onPressed: () async {
                        update();
                        // await cluesDB.update({"Note": _note.text});
                        // auth.signOut().then((value) {
                        //   Navigator.pushReplacement(context,
                        //       MaterialPageRoute(builder: (context) {
                        //     return const LoginPage();
                        //   }));
                        // });
                      },
                      child: const Text(
                        'บันทึก',
                        style: TextStyle(color: AppColor.kNavy),
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
        icon: const FaIcon(FontAwesomeIcons.floppyDisk),
        label: const Text('บันทึก'),
      ),
    );
  }

  Future<void> update() async {
    return FirebaseFirestore.instance
        .collection('cluesdata')
        .doc(widget.id)
        .update({
          'Note': _note.text,
        })
        .then((value) => Navigator.pop(context))
        // ignore: avoid_print
        .catchError((error) => print("Failed to update user: $error"));
  }

  SizedBox reportButton() {
    return SizedBox(
      height: 50,
      width: 100,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          elevation: 5,
          foregroundColor: Colors.white,
          backgroundColor: AppColor.kNavy,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32))),
        ),
        onPressed: () {},
        icon: const FaIcon(FontAwesomeIcons.fileLines),
        label: const Text('รายงาน'),
      ),
    );
  }

  // Column typeDropdown(cluesdata model) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         children: const [
  //           Text(
  //             'ประเภทคดี',
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //           ),
  //           SizedBox(
  //             width: 10,
  //           ),
  //           Text(
  //             '*สามารถแก้ไขได้',
  //             style: TextStyle(
  //               color: AppColor.kRed1,
  //             ),
  //           )
  //         ],
  //       ),
  //       _listType(model.Type),
  //     ],
  //   );
  // }

  Column details(cluesdata model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'รายละเอียดเบาะแส',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            color: AppColor.kAppbar,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  model.Detaill,
                ),
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
                      child: Text(
                        'เมื่อวันที่ : ${model.Date} เวลา : ${model.Time}',
                        style: const TextStyle(color: AppColor.kBlueGrayDark),
                      ),
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

  Column location(cluesdata model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'สถานที่พบเบาะแส',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.2,
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
                    child: Text(model.Address),
                  ),
                ),
                const Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                      color: AppColor.kCream,
                      borderRadius: BorderRadius.circular(22)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(model.Location),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  SizedBox listData(cluesdata model) {
    return SizedBox(
      width: double.infinity,
      height: 95,
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
        ],
      ),
    );
  }

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

  Column mainData() {
    return Column(
      children: [
        Row(
          children: const [
            HeaderWidgets1(),
            Spacer(),
            // SearchBarWidget(),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 55,
            right: 55,
            top: 15,
            bottom: 10,
          ),
          child: Divider(),
        ),
        const SizedBox(
          height: 20,
        ),
        // Container(
        //   margin: const EdgeInsets.only(
        //     left: 35,
        //     right: 30,
        //     bottom: 25,
        //     top: 25,
        //   ),
        //   child: Row(
        //     children: const [
        //       Text('Filter by :'),
        //     ],
        //   ),
        // ),
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
    );
  }
}
