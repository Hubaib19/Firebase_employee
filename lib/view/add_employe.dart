// ignore_for_file: use_key_in_widget_constructors, use_build_context_synchronously

import 'dart:io';
import 'package:employee_list/controller/employee_controller.dart';
import 'package:employee_list/model/employee_model.dart';
import 'package:employee_list/service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class AddEmploye extends StatelessWidget {
  AddEmploye({Key? key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'form',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, top: 30, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Center(
                    child: Consumer<EmployeeController>(
                      builder: (context, value, child) => Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: value.selectedImage != null
                                ? FileImage(File(value.selectedImage!.path))
                                : const AssetImage("assets/add image.png")
                                    as ImageProvider<Object>,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 100,
                    bottom: -10,
                    child: Consumer<EmployeeController>(
                      builder: (context, value, child) => IconButton(
                        onPressed: () {
                          value.selectImage(source: ImageSource.camera);
                        },
                        icon: const Icon(Icons.camera),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter age';
                  }
                  // You can add additional validation rules for age here
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addEmployee(context);
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addEmployee(BuildContext context) async {
    final pro = Provider.of<EmployeeController>(context, listen: false);
    String id = randomAlphaNumeric(10);
    DatabaseService service = DatabaseService();

    await service.uploadImage(
      name: nameController.text,
      fileimage: File(pro.selectedImage!.path),
    );
    final EmployeeModel employee = EmployeeModel(
      age: int.parse(ageController.text),
      id: id,
      location: locationController.text,
      name: nameController.text,
      image: service.downloadurl,
    );
    pro.addEmployee(employee: employee, id: id);
    Navigator.of(context).pop();
  }
}
