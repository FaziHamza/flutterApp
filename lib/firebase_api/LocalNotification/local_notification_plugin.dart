import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:news/main.dart';
import 'package:news/test.dart';

import '../../controllers/app_web_controller.dart';
import '../../pages/home_page.dart';

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
print("YES YES YES ${notificationResponse.payload}");
if(notificationResponse.payload!=null)
  {
    final data=jsonDecode(notificationResponse.payload!);
   // Get.put(AppWebController()).url_link.value="https://www.sportblitznews.se/news/notify/34HM9FK";
   Future.delayed(Duration(seconds: 2)).then((_)
   {
     AppWebController.to.controller.value.loadRequest(
         Uri.parse(data['deeplink']));
   });

    // AppWebController.to.controller.value.loadRequest(
    //     Uri.parse(data['deeplink']));
   // Get.off(()=>HomePage());
  //  Get.off(() => ShowNotificationNewsScreen(isFirstTime: true,link:data['deeplink'],));
    //notificationResponse.payload["deeplink"]
  }
}

Future<void>showNotification(RemoteMessage message)async{
  const detail=AndroidNotificationDetails("channelId", "channelName",
  channelDescription: 'Description',
    importance: Importance.high,
    ticker: 'ticker'
  );
  const notificationDetails=NotificationDetails(android: detail);
  await flutterLocalNotificationsPlugin.show(Random().nextInt(1000), message?.notification?.title??'', message.notification?.body??'', notificationDetails,payload: jsonEncode(message.data));
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