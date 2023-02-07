// ignore: file_names
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddData extends StatelessWidget {
  const AddData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('cluesdata').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Center(
                child: Column(children: [
                  Text(document['Type']),
                  Text(document['Date']),
                  Text(document['Time']),
                  Text(document['Location']),
                  Text(document['Name']),
                  Text(document['Phone']),
                  Text(document['Detaill']),
                ]),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
