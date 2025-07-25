import 'package:flutter/material.dart';
import 'package:push_notification/notification_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationServices().requestNotificationsPermission();
    NotificationServices().firebaseInit(context);
    NotificationServices().isTokenAlive();
    NotificationServices().getDeviceToken().then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Push Notification"),
      ),
      body: Container(),
    );
  }
}
