// ignore_for_file: use_rethrow_when_possible, avoid_print, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_list/model/employee_model.dart';

class DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addEmployee({required EmployeeModel employee, required String id}) async {
    try {
      await firestore.collection("Employees").doc(id).set(employee.toJson());
    } catch (e) {
      throw e;
    }
  }
}
