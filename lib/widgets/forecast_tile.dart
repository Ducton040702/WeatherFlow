import 'package:flutter/material.dart';

class ForecastTile extends StatelessWidget {
  final String day;
  final double temp;
  final IconData icon;

  ForecastTile({required this.day, required this.temp, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(day),
      trailing: Text('$temp°'),
    );
  }
}
