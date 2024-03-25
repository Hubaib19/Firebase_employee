// ignore_for_file: use_rethrow_when_possible, avoid_print, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    print('Error adding employee details to Firestore:');
    try {
      await FirebaseFirestore.instance
          .collection('Employee')
          .doc(id)
          .set(employeeInfoMap);
    } catch (e) {
      print('Error adding employee details to Firestore: $e');
      throw e;
    }
  }

  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return await FirebaseFirestore.instance.collection('Employee').snapshots();
  }
}
