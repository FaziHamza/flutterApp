import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news/controllers/app_controller.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AppController());
  final ApiResponseController apiResponseController =
      Get.put(ApiResponseController());

  //Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //Hive
  await Hive.initFlutter();
  await GetStorage.init();

  Hive.registerAdapter(SubtopicAdapter());
  await Hive.openBox('navbarBox');
  await Hive.openBox('settings');

  runApp(MyApp(apiResponseController: apiResponseController));
}

var localNotificationToken = ''.obs;

class MyApp extends StatelessWidget {
  final ApiResponseController apiResponseController;

  MyApp({required this.apiResponseController, super.key});

  void onDispose() {
    Hive.close();
  }

  @override
  Widget build(BuildContext context) {
    apiResponseController.fetchTopics();
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
