import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const WeatherFlowApp());
}

class WeatherFlowApp extends StatelessWidget {
  const WeatherFlowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherFlow',
      theme: ThemeData.light(),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
