import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late QuerySnapshot snapshotData;
  final TextEditingController searchController = TextEditingController();
  late bool isExcecuted = false;

  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: ListTile(
            title: Text(
              snapshotData.docs[index]['Type'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      });
    }

    return Container(
      margin: const EdgeInsets.only(
        top: 35,
        right: 55,
      ),
      width: 350,
      child: TextField(
        controller: searchController,
        decoration: const InputDecoration(
            hintText: "ค้นหา เช่น ประเภทการกระทำความผิด...",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)))),
      ),
    );
  }
}
