import 'package:flutter/material.dart';
import 'package:assignment_database/sqflite_data/database/database_student.dart';
import 'package:assignment_database/sqflite_data/model_student.dart';

class SqfliteDashBoard extends StatefulWidget {
  const SqfliteDashBoard({Key? key}) : super(key: key);

  @override
  State<SqfliteDashBoard> createState() => _SqfliteDashBoardState();
}

class _SqfliteDashBoardState extends State<SqfliteDashBoard> {
  String id = "";
  String name = "";
  DatabaseStudent databaseStudent = DatabaseStudent();

  @override
  void initState() {
    super.initState();
    setState(() {
      databaseStudent.initializeDatabase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              TextFormField(
                onChanged: (String value) {
                  setState(() {
                    id = value;
                    print("$id");
                  });
                },
                decoration: InputDecoration(labelText: "Enter ID"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (String value) {
                  setState(() {
                    name = value;
                    print("$name");
                  });
                },
                decoration: InputDecoration(labelText: "Enter Name"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (id.isNotEmpty && name.isNotEmpty) {
                    ModelStudent modelStudent =
                    ModelStudent(id: int.parse(id), name: name);

                    databaseStudent.AddStudent(modelStudent).then((value) {
                      if (value) {
                        print("Record Added Successfully");
                      } else {
                        print("Record Insertion Failed");
                      }
                    });
                  } else {
                    print("Please provide both ID and Name");
                  }
                },
                child: Text("Add Record"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (id.isNotEmpty) {
                    ModelStudent modelStudent =
                    ModelStudent(id: int.parse(id), name: name);

                    databaseStudent.UpdateStudent(modelStudent).then((value) {
                      if (value) {
                        print("Record Updated Successfully");
                      } else {
                        print("Record Updation Failed");
                      }
                    });
                  } else {
                    print("Provide ID");
                  }
                },
                child: Text("Update Record"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (id.isNotEmpty) {
                    databaseStudent.DeleteStudentById(id).then((value) {
                      if (value) {
                        print("Record Deleted Successfully");
                      } else {
                        print("Record Deletion Failed");
                      }
                    });
                  } else {
                    print("Provide ID");
                  }
                },
                child: Text("Delete Record"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  databaseStudent.GetCountStudent().then((value) {
                    print("Total Record= $value");
                  });
                },
                child: Text("Count Records"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  databaseStudent.GetAllStudent().then(
                        (List<ModelStudent> list) {
                      list.forEach((element) {
                        print("ID: ${element.id}, Name: ${element.name}");
                      });
                    },
                  );
                },
                child: Text("Display Records"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
