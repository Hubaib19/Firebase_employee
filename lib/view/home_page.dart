// ignore_for_file: use_key_in_widget_constructors

import 'package:employee_list/controller/employee_controller.dart';
import 'package:employee_list/model/employee_model.dart';
import 'package:employee_list/view/add_employe.dart';
import 'package:employee_list/view/edit_employee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<EmployeeController>(context, listen: false).fetchAllEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEmploye()),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Employee ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'detail',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      body: Consumer<EmployeeController>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.employeeList.length,
            itemBuilder: (context, index) {
              final EmployeeModel employee = value.employeeList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(employee.image!),
                          radius: 20,
                        ),
                        const SizedBox(width: 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name : ${employee.name}',
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Age : ${employee.age.toString()}',
                              style: TextStyle(
                                color: Colors.orange[800],
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Location : ${employee.location}',
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditEmployee(
                                      employee: employee,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.orange,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _showDeleteConfirmationDialog(context, employee);
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, EmployeeModel employee) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Employee?"),
          content: Text("Are you sure you want to delete ${employee.name}?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _deleteEmployee(context, employee.id!);
                Navigator.of(context).pop(); 
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _deleteEmployee(BuildContext context, String employeeId) {
    Provider.of<EmployeeController>(context, listen: false).deleteEmployee(id: employeeId);
  }
}
