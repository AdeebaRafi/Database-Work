import 'package:flutter/material.dart';
import 'package:assignment_database/apis/prayer_time.dart';

class PrayerTimesDetailPage extends StatelessWidget {
  final Datum selectedDate;

  PrayerTimesDetailPage(this.selectedDate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prayer Times for ${selectedDate.date.readable}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPrayerTime('Fajr', selectedDate.timings.fajr),
                _buildPrayerTime('Sunrise', selectedDate.timings.sunrise),
                _buildPrayerTime('Dhuhr', selectedDate.timings.dhuhr),
                _buildPrayerTime('Asr', selectedDate.timings.asr),
                _buildPrayerTime('Sunset', selectedDate.timings.sunset),
                _buildPrayerTime('Maghrib', selectedDate.timings.maghrib),
                _buildPrayerTime('Isha', selectedDate.timings.isha),
                _buildPrayerTime('Imsak', selectedDate.timings.imsak),
                _buildPrayerTime('Midnight', selectedDate.timings.midnight),
                // Add more prayer times if needed
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrayerTime(String title, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
