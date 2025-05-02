import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final double temp;
  final double high;
  final double low;
  final String condition;

  WeatherCard({required this.temp, required this.high, required this.low, required this.condition});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('$temp°', style: TextStyle(fontSize: 48)),
            Text('$condition'),
            Text('H:$high°  L:$low°'),
          ],
        ),
      ),
    );
  }
}
