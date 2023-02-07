import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:web_admin/web_admin/modelDB/cluesModel.dart';

class CluesDetailPage extends StatefulWidget {
  final cluesdata clues;
  const CluesDetailPage({super.key, required this.clues});

  @override
  State<CluesDetailPage> createState() => _CluesDetailPageState();
}

class _CluesDetailPageState extends State<CluesDetailPage> {
  late cluesdata model;
  List<Widget> widgets = [];
  List<cluesdata> cluess = [];

  @override
  void initState() {
    super.initState();
    model = widget.clues;
    readData();
  }

  Future<void> readData() async {
    await Firebase.initializeApp().then((value) async {
      // print('initializeApp Success');
      FirebaseFirestore.instance
          .collection('cluesdata')
          .snapshots()
          .listen((event) {
        // print('snapshot = ${event.docs}');
        int index = 0;
        for (var snapshots in event.docs) {
          Map<String, dynamic> map = snapshots.data();
          // print('map = $map');
          cluesdata model = cluesdata.fromMap(map);
          cluess.add(model);
          // print('Type = ${model.Type}');
          setState(() {
            widgets.add(createWidget(model, index));
          });
          index++;
        }
      });
    });
  }

  Widget createWidget(cluesdata model, int index) => GestureDetector(
        child: Column(
          children: const [
            // Text(
            //   model.Type,
            //   style: const TextStyle(fontSize: 35),
            // ),
            // Text(model.Date),
            // const SizedBox(
            //   height: 10,
            // ),
            // Text(
            //   model.Detaill,
            //   style: const TextStyle(fontSize: 15),
            // )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          Text("รายละเอียดเบาะแส : ${model.Detaill}"),
          Text("สถานที่พบเบาะแส : ${model.Location}"),
          Text("จุดประสงค์ : ${model.Point}")
        ]),
      ),
    );
  }
}
