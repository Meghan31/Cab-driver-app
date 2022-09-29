import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:taxidriver/main.dart';

import '../api/config_maps.dart';

class FCMFunctions {
  static final FCMFunctions _singleton = new FCMFunctions._internal();

  FCMFunctions._internal();

  factory FCMFunctions() {
    return _singleton;
  }
}

class PushNotificationService {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  late AndroidNotificationChannel channel;

  var channelId;
  Future<void> initialise() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      var title = notification?.title;
      var body = notification?.body;
      var rrId = message.data['ride_request_id'];
      print("onMessageOpenedApp: $title\n\n\n\n$body\n\n\n\n$rrId");

      // if (notification != null && android != null) {
      //   flutterLocalNotificationsPlugin.show(
      //     notification.hashCode,
      //     notification.title,
      //     notification.body,
      //     NotificationDetails(
      //       android: AndroidNotificationDetails(
      //         channelId = message.data['ride_request_id'],
      //         channel.name,
      //         channelDescription: channel.description,
      //         importance: Importance.max,
      //         priority: Priority.high,
      //         ticker: 'ticker',
      //         icon: "@mipmap/ic_launcher",
      //       ),
      //     ),
      //   );
      // }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      var n = jsonDecode(message.toString());
      var title = n['notification']['title'];
      var body = n['notification']['body'];
      var rrId = n['data']['ride_request_id'];
      print("onMessageOpenedApp: $title\n\n\n\n$body\n\n\n\n$rrId");
    });
  }

  Future<String?> getToken() async {
    String? token = await firebaseMessaging.getToken();
    print("token: $token");
    driversRef.child(currentFirebaseUser!.uid).child('token').set(token);
  }
}
