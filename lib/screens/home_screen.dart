import 'package:flutter/material.dart';
import '../widgets/weather_card.dart';
import '../widgets/forecast_tile.dart';
import '../services/weather_service.dart'; // OpenWeatherMap API
import '../services/firebase_service.dart'; // Firebase service
import 'package:share_plus/share_plus.dart';
import 'map_screen.dart';
import 'community_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WeatherFlow'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {}, // settings button
          ),
        ],
      ),
      body: Column(
        children: [
          // Location button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              minimumSize: Size(double.infinity, 40),
            ),
            child: Text('Location'),
          ),

          Expanded(
            child: Row(
              children: [
                // Left side: Temp + High/Low
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '72°',
                        style: TextStyle(fontSize: 80, color: Colors.orange),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('H:80°'),
                          SizedBox(width: 10),
                          Text('L:69°'),
                        ],
                      ),
                    ],
                  ),
                ),

                // Right side buttons
                Expanded(
                  child: Column(
                    children: [
                      _buildSideButton(
                        'Rain starting in 10 min',
                        Colors.lightBlue,
                      ),
                      _buildSideButton('Custom theme', Colors.grey),
                      _buildSideButton('Share', Colors.green),
                      _buildSideButton('Report', Colors.red),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Forecast tiles
          Row(
            children: [
              _buildForecastTile('Now', '72°', Icons.wb_sunny),
              _buildForecastTile('70 / 58', '', Icons.cloud),
              _buildForecastTile('65 / 50', '', Icons.umbrella),
            ],
          ),

          // 7-day forecast
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '7-day forecast',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tuesday 78° ☀️',
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                  Text(
                    'Wednesday 70° 🌧️',
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                  Text(
                    'Thursday 69° ⚡',
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                  Text(
                    'Friday 75° ☁️',
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideButton(String text, Color color) {
    return Expanded(
      child: Container(
        color: color,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildForecastTile(String title, String subtitle, IconData icon) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.all(4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 32),
              Text(title),
              if (subtitle.isNotEmpty) Text(subtitle),
            ],
          ),
        ),
      ),
    );
  }
}
