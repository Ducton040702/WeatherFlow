import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';  
import 'screens/home_screen.dart';  // Make sure this path is correct!

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(WeatherFlowApp());
}

class WeatherFlowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherFlow',
      theme: ThemeData.light(),
      home: HomeScreen(),  // Make sure you have a HomeScreen widget!
      debugShowCheckedModeBanner: false,
    );
  }
}
