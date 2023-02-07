import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/web_admin/modelDB/cluesDetails.dart';
import 'package:web_admin/web_admin/modelDB/cluesModel.dart';


class CluesPage extends StatefulWidget {
  const CluesPage({super.key});

  @override
  State<CluesPage> createState() => _CluesPageState();
}

class _CluesPageState extends State<CluesPage> {
  List<Widget> widgets = [];
  List<cluesdata> clues = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    await Firebase.initializeApp().then((value) async {
      print('initializeApp Success');
      await FirebaseFirestore.instance
          .collection('cluesdata')
          .orderBy('Date')
          .snapshots()
          .listen((event) {
        print('snapshot = ${event.docs}');
        int index = 0;
        for (var snapshots in event.docs) {
          Map<String, dynamic> map = snapshots.data();
          print('map = $map');
          cluesdata model = cluesdata.fromMap(map);
          clues.add(model);
          print('Date = ${model.Type}');
          setState(() {
            widgets.add(createWidget(model, index));
          });
          index++;
        }
      });
    });
  }

  Widget createWidget(cluesdata model, int index) => GestureDetector(
        // onTap: () {
        //   print('You Click from index = $index');
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => CafeDetailPage(cafe: cafes[index])));
        // },
        child: Card(
          color: Colors.blue[100],
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(21),
          // ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   width: 250,
                  //   child: Image.network(
                  //     model.image,
                  //   ),
                  // ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    model.Type,
                    style: const TextStyle(fontSize: 20),
                  ),
                  // Text(model.detail)
                  // const Divider(
                  //   thickness: 2,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.blue.withAlpha(50),
                          alignment: Alignment.center,
                          child: TextButton(
                            child: const Text('อ่านเพิ่มเติม'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CluesDetails(
                                            cluess: clues[index],
                                          )));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: widgets,
            ),
    );
  }
}
