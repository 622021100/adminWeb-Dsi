import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/web_admin/newFloder/common/app_colors.dart';

class RecruitemDatawidget extends StatefulWidget {
  // final cluesdata cluess;

  const RecruitemDatawidget({super.key});

  @override
  State<RecruitemDatawidget> createState() => _RecruitemDatawidgetState();
}

class _RecruitemDatawidgetState extends State<RecruitemDatawidget> {
  // late cluesdata model;
  // List<Widget> widgets = [];
  // List<cluesdata> clues = [];

  // @override
  // void initState() {
  //   super.initState();
  //   model = widget.cluess;
  //   readData();
  // }

  // Future<void> readData() async {
  //   await Firebase.initializeApp().then((value) async {
  //     print('initializeApp Success');
  //     await FirebaseFirestore.instance
  //         .collection('cluesdata')
  //         .where('Type')
  //         .snapshots()
  //         .listen((event) {
  //       print('snapshot = ${event.docs}');
  //       int index = 0;
  //       for (var snapshots in event.docs) {
  //         Map<String, dynamic> map = snapshots.data();
  //         print('map = $map');
  //         cluesdata model = cluesdata.fromMap(map);
  //         clues.add(model);
  //         print('Type = ${model.Type}');
  //         setState(() {
  //           widgets.add(build(context));
  //         });
  //         index++;
  //       }
  //     });
  //   });
  // }

  // Widget createWidget(cluesdata model, int index) => GestureDetector(
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Container(
  //           color: Colors.white,
  //           child: Center(
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Container(
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(21),
  //                     ),
  //                     width: 350,
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   Text(
  //                     model.Type,
  //                     style: TextStyle(fontSize: 35),
  //                   ),
  //                   Row(
  //                     children: [
  //                       Text(model.Date),
  //                       const SizedBox(
  //                         height: 5,
  //                       ),
  //                       Text(model.Time),
  //                     ],
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   Text(
  //                     model.Location,
  //                     style: TextStyle(fontSize: 15),
  //                   ),
  //                   Text(
  //                     model.Detaill,
  //                     style: TextStyle(fontSize: 15),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("cluesdata").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: FittedBox(
                    child: Text(document["Date"]),
                  ),
                ),
                title: Text(document["Name"]),
              );
            }).toList(),
          );
        },
      ),
    );
    // Container(
    //   margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    //   decoration: BoxDecoration(
    //     color: AppColor.kCream,
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    //   padding: const EdgeInsets.all(20),
    //   child: Column(children: []),

    //   // child: Column(
    //   //   children: [
    //   //     Row(
    //   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   //       children: [
    //   //         const Text(
    //   //           "ข้อมูลแจ้งเบาะแสทางการข่าว",
    //   //           style: TextStyle(
    //   //             fontWeight: FontWeight.bold,
    //   //             color: AppColor.kNavy,
    //   //             fontSize: 18,
    //   //           ),
    //   //         ),
    //   //         // GestureDetector(
    //   //         //   onTap: () {},
    //   //         //   child: Container(
    //   //         //     decoration: BoxDecoration(
    //   //         //       color: AppColor.kYellow,
    //   //         //       borderRadius: BorderRadius.circular(100),
    //   //         //     ),
    //   //         //     padding: const EdgeInsets.symmetric(
    //   //         //       horizontal: 20,
    //   //         //       vertical: 10,
    //   //         //     ),
    //   //         //     child: const Text(
    //   //         //       "View All",
    //   //         //       style: TextStyle(
    //   //         //         fontWeight: FontWeight.bold,
    //   //         //         color: AppColor.kNavy,
    //   //         //       ),
    //   //         //     ),
    //   //         //   ),
    //   //         // ),
    //   //         SizedBox(
    //   //           width: 100,
    //   //           height: 50,
    //   //           child: ElevatedButton(
    //   //             style: ElevatedButton.styleFrom(
    //   //                 backgroundColor: AppColor.kYellow,
    //   //                 shape: RoundedRectangleBorder(
    //   //                   borderRadius: BorderRadius.circular(36),
    //   //                   side: BorderSide.none,
    //   //                 )),
    //   //             onPressed: () {
    //   //               // auth.signOut().then((value) {
    //   //               //   Navigator.pushReplacement(context,
    //   //               //       MaterialPageRoute(builder: (context) {
    //   //               //     return const LoginPage();
    //   //               //   }));
    //   //               // });
    //   //             },
    //   //             child: const Text(
    //   //               "ดูทั้งหมด",
    //   //               style: TextStyle(color: AppColor.kNavy),
    //   //             ),
    //   //           ),
    //   //         ),
    //   //       ],
    //   //     ),
    //   //     const Divider(
    //   //       thickness: 2,
    //   //       color: Colors.grey,
    //   //     ),
    //   //     Table(
    //   //       defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    //   //       children: [
    //   //         ///Table Header
    //   //         TableRow(
    //   //           decoration: const BoxDecoration(
    //   //             border: Border(
    //   //                 bottom: BorderSide(
    //   //               color: Colors.grey,
    //   //               width: 2,
    //   //             )),
    //   //           ),
    //   //           children: [
    //   //             tableHeader("วันที่"),
    //   //             tableHeader("เวลา"),
    //   //             tableHeader("ประเภทการกระทำความผิด"),
    //   //             tableHeader("สถานที่พบเบาะแส"),
    //   //             tableHeader("ชื่อผู้แจ้ง"),
    //   //             tableHeader("เบอร์โทรผู้แจ้ง"),
    //   //             tableHeader(""),
    //   //           ],
    //   //         ),
    //   //         tableRow(
    //   //           context,
    //   //           date: "2023-01-15",
    //   //           time: "10.00",
    //   //           type: " ",
    //   //           location:
    //   //               "411 ม.2 ชุมชนพงเพชรแจ้งวัฒนะ 14 แขวงทุ่งสองห้อง เขตหลักสี่ กรุงเทพฯ 10210",
    //   //           name: "แป้ง",
    //   //           phone: "0943179190",
    //   //         ),
    //   //         tableRow(
    //   //           context,
    //   //           date: "2023-01-15",
    //   //           time: "10.00",
    //   //           type: " ",
    //   //           location:
    //   //               "411 ม.2 ชุมชนพงเพชรแจ้งวัฒนะ 14 แขวงทุ่งสองห้อง เขตหลักสี่ กรุงเทพฯ 10210",
    //   //           name: "แป้ง",
    //   //           phone: "0943179190",
    //   //         ),
    //   //         // const TableRow(
    //   //         //   decoration: BoxDecoration(
    //   //         //     border: Border(
    //   //         //         bottom: BorderSide(
    //   //         //       color: Colors.grey,
    //   //         //       width: 0.5,
    //   //         //     )),
    //   //         //   ),
    //   //         //   children: [
    //   //         //     Text("คดีความผิดตามกฎหมายว่าด้วยป่าไม้"),
    //   //         //     Text("2021-1-5 10:00"),
    //   //         //     Text("อรอนงค์ คงดำ 0943179190"),
    //   //         //     Text(""),
    //   //         //   ],
    //   //         // ),
    //   //       ],
    //   //     )
    //   //   ],
    //   // ),
    // );
  }

  TableRow tableRow(
    context, {
    date,
    time,
    type,
    location,
    name,
    phone,
  }) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(
          color: Colors.grey,
          width: 0.5,
        )),
      ),
      children: [
        Text(date),
        Text(time),
        Text(type),
        Text(location),
        Text(name),
        Text(phone),
        Image.asset(
          'assets/images/more.png',
          height: 30,
          color: Colors.grey,
        )
      ],
    );
  }

  Widget tableHeader(text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColor.kNavy,
        ),
      ),
    );
  }
}
