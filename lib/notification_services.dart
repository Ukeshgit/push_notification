import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging message = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotificationsPermission() async {
    NotificationSettings settings = await message.requestPermission(
      alert: true,
      announcement: true,
      carPlay: true,
      badge: true,
      sound: true,
      criticalAlert: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User Granted Permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User Granted Provisional Permission");
    } else {
      print("User Denied");
    }
  }

  void initLocalNotifications(
    BuildContext context,
    RemoteMessage message,
  ) async {
    var androidInitializationSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    var iosInitializationSettings = DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // handle tap on notification
      },
    );
  }

  void showNotifications(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(1000).toString(),
      "High important notifications",
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          channel.id.toString(),
          channel.name.toString(),
          channelDescription: channel.description.toString(),
          importance: Importance.high,
          priority: Priority.high,
          ticker: 'ticker',
          icon: 'mipmap/ic_launcher',
        );

    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration(seconds: 0), () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((msg) {
      print(msg.notification!.title.toString());
      if (kDebugMode) {
        print(msg.notification!.body.toString());
      }

      if (Platform.isAndroid) {
        initLocalNotifications(context, msg);
        showNotifications(msg);
      }
    });
  }

  Future<String?> getDeviceToken() async {
    var token = await message.getToken();
    return token;
  }

  void isTokenAlive() {
    message.onTokenRefresh.listen((event) {
      event.toString();
      print("Token Refreshed Now!!!");
    });
  }
}
