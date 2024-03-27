import 'dart:io';

import 'package:employee_list/model/employee_model.dart';
import 'package:employee_list/service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EmployeeController extends ChangeNotifier {
  List<EmployeeModel> employeeList = [];
  DatabaseService service = DatabaseService();
  File? selectedImage;

  void selectImage({required source}) async {
    final returnedImage = await ImagePicker().pickImage(source: source);
    if (returnedImage != null) {
      selectedImage = File(returnedImage.path);
      notifyListeners();
    }
  }

  List<EmployeeModel> fetchAllEmployees() {
    try {
      service.firestore.collection("Employees").snapshots().listen((employee) {
        employeeList = employee.docs
            .map((employee) => EmployeeModel.fromJson(employee.data()))
            .toList();
        notifyListeners();
      });
      return employeeList;
    } catch (e) {
      rethrow;
    }
  }

  addEmployee({required EmployeeModel employee, required String id}) {
    return service.addEmployee(employee: employee, id: id);
  }

  updateEmployee({required String id, required EmployeeModel employee}) {
    return service.updateEmployee(id: id, employee: employee);
  }
}
