// ignore_for_file: use_rethrow_when_possible, avoid_print, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_list/model/employee_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Reference storage = FirebaseStorage.instance.ref();
  String downloadurl = "";

  addEmployee({required EmployeeModel employee, required String id}) async {
    try {
      await firestore.collection("Employees").doc(id).set(employee.toJson());
    } catch (e) {
      throw e;
    }
  }

  uploadImage({required String name,required fileimage})async{
    final childfolder = storage.child("employee_images");
   final image =  childfolder.child("${name}.jpg");
    try {
      await image.putFile(fileimage);
      downloadurl = await image.getDownloadURL();
    } catch (e) {
      throw Exception(e);
    }
  }

  updateEmployee({required String id,required EmployeeModel employee})async{
    try {
      await firestore.collection("Employees").doc(id).update(employee.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}
