import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../pages/home_page.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool isFlutterLocalNotificationsInitialized = false;

  handleMessage(RemoteMessage? message) {
    if (message == null) return;

    print(message.notification?.title);
    if(message.data['deeplink']!=null)
    {
      Get.off(() => HomePage(isFirstTime: true,link:message.data['deeplink'],));
    }
  }
  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        payload: jsonEncode(message.toMap()),
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@drawable/logo',
          ),
        ),
      );
    }
  }
  Future<void> initLocalNotification() async {
    final InitializationSettings initializationSettings =
        const InitializationSettings(
      android: AndroidInitializationSettings("@drawable/logo"),
      // iOS: initializationSettingsDarwin,
      // macOS: initializationSettingsDarwin,
      // linux: initializationSettingsLinux,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        print('notificaitonResponse ${notificationResponse.payload}');
        // switch (notificationResponse.notificationResponseType) {
        // case NotificationResponseType.selectedNotification:
        //   selectNotificationStream.add(notificationResponse.payload);
        //   break;
        // case NotificationResponseType.selectedNotificationAction:
        //   if (notificationResponse.actionId == navigationActionId) {
        //     selectNotificationStream.add(notificationResponse.payload);
        //   }
        //   break;
        // }
      },
      // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  initPushNotification() {
    _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
     FirebaseMessaging.onMessage.listen(showFlutterNotification);
  }

  initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print('token :: $fcmToken');
    await setupFlutterNotifications();
    initLocalNotification();
    initPushNotification();
  }

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }
}

Future<void> handleBackgroundMessage(RemoteMessage? message) async {
  if (message == null) return;

  print(message.notification?.title);
  print(message.notification?.body);
  // if(message.data['screen']!=null)
  //   {
  //     print("hjkhkjhjk");
  //     // Get.to(() => NextPage(
  //     //   title: "Text",
  //     //   url: "https://www.sportblitznews.se/news/dressyr_/18cd3649-f47b-4941-6fd6-08dc892026a2",
  //     //   logImage: "logo",
  //     // ));
  //   }

}