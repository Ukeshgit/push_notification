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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
