import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:web_admin/web_admin/modelDB/cluesModel.dart';

class CluesDetails extends StatefulWidget {
  final cluesdata cluess;
  CluesDetails({Key? key, required this.cluess}) : super(key: key);

  @override
  State<CluesDetails> createState() => _CluesDetailsState();
}

class _CluesDetailsState extends State<CluesDetails> {
  late cluesdata model;
  List<Widget> widgets = [];
  List<cluesdata> clues = [];

  @override
  void initState() {
    super.initState();
    model = widget.cluess;
    readData();
  }

  Future<void> readData() async {
    await Firebase.initializeApp().then((value) async {
      print('initializeApp Success');
      await FirebaseFirestore.instance
          .collection('cluesdata')
          .where('Type')
          .snapshots()
          .listen((event) {
        print('snapshot = ${event.docs}');
        int index = 0;
        for (var snapshots in event.docs) {
          Map<String, dynamic> map = snapshots.data();
          print('map = $map');
          cluesdata model = cluesdata.fromMap(map);
          clues.add(model);
          print('Type = ${model.Type}');
          setState(() {
            widgets.add(createWidget(model, index));
          });
          index++;
        }
      });
    });
  }

  Widget createWidget(cluesdata model, int index) => GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.white,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                      ),
                      width: 350,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      model.Type,
                      style: TextStyle(fontSize: 35),
                    ),
                    Row(
                      children: [
                        Text(model.Date),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(model.Time),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      model.Location,
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      model.Detaill,
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  model.Type,
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(model.Date),
                Text(model.Time),
                Text(model.Location),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              model.Detaill,
              style: TextStyle(fontSize: 20),
            ),
            // SizedBox(
            //   height: 150,
            //   width: 350,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: <Widget>[
            //       Image.network(model.image),
            //       Image.network(model.image),
            //       Image.network(model.image)
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    ));
  }
}
