import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveDashboardScreen extends StatefulWidget {
  const HiveDashboardScreen({Key? key}) : super(key: key);

  @override
  State<HiveDashboardScreen> createState() => _HiveDashboardScreenState();
}

class _HiveDashboardScreenState extends State<HiveDashboardScreen> {
  List<Map<String, dynamic>> record = [];
  final stdRecord = Hive.box('Student_Record');

  @override
  void initState() {
    super.initState();
    refreshItem();
  }

  void refreshItem() {
    final data = stdRecord.keys.map((key) {
      final item = stdRecord.get(key);
      return {
        "key": key,
        "name": item!["name"],
        "rollnum": item["rollnum"],
        "gpa": item["gpa"]
      };
    }).toList();

    setState(() {
      record = data.reversed.toList();
      print(record.length);
    });
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController gpaController = TextEditingController();

  Future<void> _createItem(Map<String, dynamic> newRecord) async {
    await stdRecord.add(newRecord);
    refreshItem();
  }

  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await stdRecord.put(itemKey, item);
    refreshItem();
  }

  Future<void> _deleteItem(int itemKey) async {
    await stdRecord.delete(itemKey);
    refreshItem();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An Item has been deleted')));
  }

  void showForm(BuildContext cntx, int? itemKey) async {
    if (itemKey != null) {
      final existingItem =
      record.firstWhere((element) => element['key'] == itemKey);
      usernameController.text = existingItem['name'];
      rollNoController.text = existingItem['rollnum'];
      gpaController.text = existingItem['gpa'];
    }

    showModalBottomSheet(
      context: cntx,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(cntx).viewInsets.bottom,
          top: 15,
          left: 15,
          right: 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: "Student Name",
                labelText: "Name",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: rollNoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Student Roll No",
                labelText: "Roll No",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: gpaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Student GPA",
                labelText: "GPA",
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                if (itemKey == null) {
                  _createItem({
                    "name": usernameController.text,
                    "rollnum": rollNoController.text,
                    "gpa": gpaController.text
                  });
                }
                if (itemKey != null) {
                  _updateItem(itemKey, {
                    'name': usernameController.text.trim(),
                    'rollnum': rollNoController.text.trim(),
                    'gpa': gpaController.text.trim(),
                  });
                }

                usernameController.text = '';
                rollNoController.text = '';
                gpaController.text = '';
                Navigator.of(context).pop();
              },
              child: const Text("Add Data"),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive Dashboard"),
        backgroundColor: Color(0xFFE91E63), // Pink color
      ),
      body: ListView.builder(
        itemCount: record.length,
        itemBuilder: (_, index) {
          final currentItem = record[index];
          return Card(
            color: Color(0xFFE91E63), // Pink color
            margin: const EdgeInsets.all(10),
            elevation: 3,
            child: ListTile(
              title: Text(
                currentItem['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Roll No: ${currentItem['rollnum']}   GPA: ${currentItem['gpa']}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => showForm(context, currentItem['key'] as int?),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteItem(currentItem['key'] as int),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showForm(context, null),
        child: const Icon(Icons.add),
        backgroundColor: Color(0xFFE91E63), // Pink color
      ),
    );
  }
}
