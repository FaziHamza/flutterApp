import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:news/pages/next_page.dart';

import '../controllers/app_web_controller.dart';
import '../firebase_options.dart';
import 'LocalNotification/local_notification_plugin.dart';
@pragma('vm:entry-point')
Future<void>firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void _handleOpenedMassage(RemoteMessage message)
{
  if(message.data!=null)
    {
      Future.delayed(Duration(seconds: 1)).then((_)
      {
        // AppWebController.to.controller.value.loadRequest(
        //     Uri.parse(message.data['deeplink']));
             Get.off(()=> NextPage(title: '',logImage: '',url: message.data['deeplink'], hideBar: true));
      });
      
    }
}
void _onRenewToken(String token)
{
  print("TOKEN ::$token");
}
Future<void>setupInteractedMessage()async{
  // RemoteMessage? initMes=await FirebaseMessaging.instance.getInitialMessage();
  // if(initMes !=null)
  // {
  //   _handleMessage(initMes);
  // }
  FirebaseMessaging.onMessageOpenedApp.listen(_handleOpenedMassage);
  FirebaseMessaging.onMessage.listen(_handleMessage);
  FirebaseMessaging.instance.onTokenRefresh.listen(_onRenewToken);
  final fcmToken=await FirebaseMessaging.instance.getToken();
  print('Token $fcmToken');
}
void _handleMessage(RemoteMessage message)async
{
  //To show notification
  await showNotification(message);
}