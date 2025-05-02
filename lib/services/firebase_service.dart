import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> saveReport(String reportText) async {
    await firestore.collection('reports').add({
      'text': reportText,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> initNotifications() async {
    await messaging.requestPermission();
    String? token = await messaging.getToken();
    print('Firebase Messaging Token: $token');
  }
}
