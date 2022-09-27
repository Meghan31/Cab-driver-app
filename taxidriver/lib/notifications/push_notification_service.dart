import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:taxidriver/main.dart';

import '../api/config_maps.dart';

class PushNotificationService {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  PushNotificationService._();

  factory PushNotificationService() => _instance;

  static final PushNotificationService _instance = PushNotificationService._();

  Future<void> initialise() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print("onMessage: $message");
      print("onMessage.Notification: $notification");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print("onMessage: $message");
      print("onMessage.Notification: $notification");
    });
  }

  Future<String?> getToken() async {
    String? token = await firebaseMessaging.getToken();
    driversRef.child(currentFirebaseUser!.uid).child('token').set(token);
    print("token: $token");

    firebaseMessaging.subscribeToTopic('alldrivers');
  }
}
