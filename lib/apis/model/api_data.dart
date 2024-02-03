import 'package:flutter/material.dart';
import 'package:assignment_database/apis/model/api_data.dart';
import 'package:assignment_database/apis/services/api_service.dart';

import '../detail_prayer_time.dart';
import '../prayer_time.dart';

class ApiDashboard extends StatefulWidget {
  @override
  _ApiDashboardState createState() => _ApiDashboardState();
}

class _ApiDashboardState extends State<ApiDashboard> {
  final PrayerTimesService _prayerTimeService = PrayerTimesService();
  late Future<PrayerTime> _prayerTimeData;

  @override
  void initState() {
    super.initState();
    _prayerTimeData = _prayerTimeService.getPrayerTimeData();
  }

  void onDateClick(Datum selectedDate) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PrayerTimesDetailPage(selectedDate),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prayer Times'),
      ),
      body: FutureBuilder<PrayerTime>(
        future: _prayerTimeData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While data is being fetched, show a loading indicator
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If there's an error in fetching data, show an error message
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Data has been successfully fetched, display the ListView
            return ListView.builder(
              itemCount: snapshot.data!.data.length,
              itemBuilder: (context, index) {
                Datum prayerData = snapshot.data!.data[index];
                return ListTile(
                  title: Text(prayerData.date.readable),
                  onTap: () => onDateClick(prayerData),
                );
              },
            );
          }
        },
      ),
    );
  }
}
