import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices {
  FirebaseMessaging message = FirebaseMessaging.instance;

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
}
