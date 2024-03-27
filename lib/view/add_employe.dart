// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:employee_list/controller/employee_controller.dart';
import 'package:employee_list/model/employee_model.dart';
import 'package:employee_list/service/data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class AddEmploye extends StatelessWidget {
  AddEmploye({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Employee ',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'form',
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, top: 30, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              children: [
                Center(
                  child: Consumer<EmployeeController>(
                    builder: (context, value, child) => 
                   Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: value.selectedImage!=null?FileImage(File(value.selectedImage!.path)):AssetImage("assets/add image.png")as ImageProvider,fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.yellow
                      ),
                    ),
                  ),
                ),
                Positioned(
                   right: 100,
                   bottom: -10
                ,
                  child: Consumer<EmployeeController>(
                    builder: (context, value, child) => 
                     IconButton(onPressed: (){
                      value.selectImage(source: ImageSource.camera);
                     }, icon: Icon(Icons.camera),)
                    ),
                    )
              ],
            ),
            const Text(
              'Name',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Age',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: ageController,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Location',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: locationController,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  addEmployee(context);
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addEmployee(BuildContext context)async {
    final pro = Provider.of<EmployeeController>(context, listen: false);
    String id = randomAlphaNumeric(10);
    DatabaseService service  = DatabaseService();
    

    await service.uploadImage(name: nameController.text, fileimage: File(pro.selectedImage!.path));
    final EmployeeModel employee = EmployeeModel(
      age: int.parse(ageController.text),
      id: id,
      location: locationController.text,
      name: nameController.text,
      image: service.downloadurl
    );
    pro.addEmployee(employee: employee, id: id);
    Navigator.of(context).pop();
  }
}
