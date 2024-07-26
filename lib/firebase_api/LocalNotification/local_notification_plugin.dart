import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:news/pages/next_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
final StreamController<String?> selectNotificationStream=StreamController<String?>.broadcast();
Future<void>requestNotificationPermissions()async{
  //Only for android
  if(Platform.isAndroid)
    {
      final androidImplement=flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      await androidImplement?.requestNotificationsPermission();
    }

}

Future<bool>isAndroidPermissionGranted()async{
  if(Platform.isAndroid){
    return await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.areNotificationsEnabled()??false;
  }
  return false;
}

void notificationTapBackground(NotificationResponse notificationResponse)
{
if (kDebugMode) {
  print("YES YES YES ${notificationResponse.payload}");
}
if(notificationResponse.payload!=null)
  {
    final data=jsonDecode(notificationResponse.payload!);
   Future.delayed(const Duration(seconds: 1)).then((_)
   {
          if (kDebugMode) {
            print("Nitification link: ${data['deeplink']}");
          }
         Get.off(()=> NextPage(title: '',logImage: '',url: data['deeplink'], hideBar: true,));
   });
  }
}

Future<void>showNotification(RemoteMessage message)async{
  const detail=AndroidNotificationDetails("channelId", "channelName",
  channelDescription: 'Description',
    importance: Importance.high,
    ticker: 'ticker'
  );
  const notificationDetails=NotificationDetails(android: detail);
  await flutterLocalNotificationsPlugin.show(Random().nextInt(1000), message.notification?.title??'', message.notification?.body??'', notificationDetails,payload: jsonEncode(message.data));
}

Future<void>initLocalNotification()async
{
 // const settingForAndroid=AndroidInitializationSettings('launch_background');
  const settingForAndroid=AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosInitializationSetting = DarwinInitializationSettings();
  const initializationSettings=InitializationSettings(android: settingForAndroid,iOS: iosInitializationSetting);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    onDidReceiveNotificationResponse: notificationTapBackground
  );
}