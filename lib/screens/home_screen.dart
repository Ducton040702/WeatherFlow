import 'package:flutter/material.dart';
import '../widgets/weather_card.dart';
import '../widgets/forecast_tile.dart';
import '../services/weather_service.dart'; // OpenWeatherMap API
import '../services/firebase_service.dart'; // ✅ Firebase service
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final firebaseService = FirebaseService(); // ✅ Firebase service instance
  final TextEditingController _reportController = TextEditingController(); // ✅ Controller for report input

  String location = "New York"; // Default location
  double temp = 72;
  double highTemp = 80;
  double lowTemp = 69;
  String condition = "Sunny";

  List<Map<String, dynamic>> forecast = [
    {"day": "Tue", "temp": 78, "icon": Icons.wb_sunny},
    {"day": "Wed", "temp": 70, "icon": Icons.cloud},
    {"day": "Thu", "temp": 69, "icon": Icons.thunderstorm},
    {"day": "Fri", "temp": 75, "icon": Icons.wb_sunny},
  ];

  @override
  void initState() {
    super.initState();
    // ✅ Initialize Firebase messaging
    firebaseService.initNotifications();

  }

  void shareWeather() {
    Share.share('Current weather in $location: $temp°F, $condition');
  }

  void reportWeather() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Report Observation'),
        content: TextField(
          controller: _reportController, // ✅ capture user input
          decoration: InputDecoration(hintText: 'Enter your observation...'),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              String reportText = _reportController.text.trim();
              if (reportText.isNotEmpty) {
                await firebaseService.saveReport(reportText); // ✅ save to Firestore
              }
              Navigator.pop(context);
              _reportController.clear();
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WeatherFlow'),
        actions: [IconButton(icon: Icon(Icons.settings), onPressed: () {})],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            // Location input
            TextField(
              decoration: InputDecoration(labelText: 'Location'),
              onSubmitted: (val) => setState(() => location = val),
            ),
            SizedBox(height: 10),
            WeatherCard(temp: temp, high: highTemp, low: lowTemp, condition: condition),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => print("Rain alert triggered"),
                    child: Text('Rain starting in 10 min'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => print("Custom theme coming soon"),
                    child: Text('Custom Theme'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(onPressed: shareWeather, child: Text('Share')),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(onPressed: reportWeather, child: Text('Report')),
                ),
              ],
            ),
            SizedBox(height: 10),
            Align(alignment: Alignment.centerLeft, child: Text('7-day forecast', style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(
              child: ListView.builder(
                itemCount: forecast.length,
                itemBuilder: (context, index) {
                  return ForecastTile(
                    day: forecast[index]['day'],
                    temp: forecast[index]['temp'],
                    icon: forecast[index]['icon'],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
