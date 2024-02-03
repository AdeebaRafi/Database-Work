import 'package:assignment_database/sqflite_data/sqflite_dashboard.dart';
import 'package:flutter/material.dart';
import 'apis/model/api_data.dart';
import 'hive/hive_dashboard_screen.dart';


class ScreenDashboard extends StatefulWidget {
  const ScreenDashboard({super.key});

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Database Assignment"),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            ElevatedButton(onPressed: () {

              Navigator.push(context, MaterialPageRoute(builder: (builder) => ApiDashboard()));
            }, child: const Text("Apis Dashboard")),


            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder) => SqfliteDashBoard()));

            }, child: const Text("SQFlite Dashboard")),


            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder) => HiveDashboardScreen()));

            }, child: const Text("Hive Dashboard")),



          ],
        ),
      ),

    );
  }
}
