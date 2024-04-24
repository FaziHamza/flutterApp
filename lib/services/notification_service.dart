import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationService {
  void setNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  void handleMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        showNotificationDialog(message);
      }
    });
  }

  void postMessageHandler() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  }

  void showNotificationDialog(RemoteMessage message) async {
    return await showDialog(
        context: Get.context!,
        builder: (_) => AlertDialog(
              title: Text(message.notification!.title!),
              content: Text(message.notification!.body!),
              actions: [
                TextButton(
                    onPressed: () => Get.back(), child: const Text('CANCEL')),
              ],
            ));
  }
}
