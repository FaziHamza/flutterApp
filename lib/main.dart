import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news/controllers/app_controller.dart';
import 'package:news/firebase_api/firebase_api.dart';
import 'package:news/helper/ad_helper.dart';
import 'package:news/pages/home_page.dart';
import 'package:news/services/notification_service.dart';
import 'package:news/utils/app_color_swatch.dart';
import 'package:news/utils/subtopic_navitem_controller.dart';

import 'firebase_options.dart';
import 'models/api_response_controller.dart';
import 'models/subtopic.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // other Firebase background services initialization here
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
  NotificationService().handleMessaging();
  NotificationService().postMessageHandler();
}

getToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  print("Token ; $token");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AppController());
  FacebookAppEvents().setAutoLogAppEventsEnabled(true);
  // FacebookAppEvents().setAppId("YOUR_APP_ID");
  // AdHelper.init();
  final ApiResponseController apiResponseController =
      Get.put(ApiResponseController());
  //Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseApi().initNotification();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.setAnalyticsCollectionEnabled(true);

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // getToken();

  //Hive
  await Hive.initFlutter();
  await GetStorage.init();

  Hive.registerAdapter(SubtopicAdapter());
  await Hive.openBox('navbarBox');
  await Hive.openBox('settings');

  runApp(MyApp(apiResponseController: apiResponseController));
}

var localNotificationToken = ''.obs;

class MyApp extends StatefulWidget {
  final ApiResponseController apiResponseController;

  MyApp({required this.apiResponseController, super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void onDispose() {
    Hive.close();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.apiResponseController.fetchTopics();
    var navController = Get.put(SubtopicNavController());
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SportBlitz News',
        theme: ThemeData(
          brightness: Brightness.dark,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.transparent,
          ),
          primarySwatch: AppColorSwatch.customBlack,
          switchTheme: SwitchThemeData(
            thumbColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.black45;
              }
              return Colors.black;
            }),
            trackColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.white54;
              }
              return Colors.white;
            }),
          ),
        ),
        onDispose: onDispose,
        home: HomePage()
        // PreferenceService().isPreferencePageAllowed()
        //     ? HomePage()
        //     : PreferencePage(),
        );
  }
}
