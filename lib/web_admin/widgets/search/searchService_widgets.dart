import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  // ignore: non_constant_identifier_names
  Future getData(String Collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firebaseFirestore.collection(Collection).get();
    return snapshot.docs;
  }

  Future queryData(String querySnapshot) async {
    return FirebaseFirestore.instance
        .collection('cluesdata')
        .where('Type', isGreaterThanOrEqualTo: querySnapshot)
        .get();
  }
}
