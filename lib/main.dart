import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news/controllers/app_controller.dart';
import 'package:news/pages/home_page.dart';
import 'package:news/services/preference_service.dart';
import 'package:news/services/subtopic_service.dart';
import 'package:news/utils/CustomColors.dart';
import 'package:news/utils/app_color_swatch.dart';
import 'package:news/utils/subtopic_navitem_controller.dart';

import 'firebase_api/LocalNotification/local_notification_plugin.dart';
import 'firebase_api/firebase_messaging_plugin.dart';
import 'firebase_options.dart';
import 'models/api_response_controller.dart';
import 'models/subtopic.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await initLocalNotification();
  Get.put(AppController());

  final ApiResponseController apiResponseController =
      Get.put(ApiResponseController());

  //Firebase
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.setAnalyticsCollectionEnabled(true);

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

  const MyApp({required this.apiResponseController, super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system; // Default to system theme

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

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
    Get.put(SubtopicNavController());
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
            thumbColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.black45;
              }
              return Colors.black;
            }),
            trackColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.white54;
              }
              return Colors.white;
            }),
          ),
        ),
        onDispose: onDispose,
        home: const MyhomePage()
        );
  }
}

class MyhomePage extends StatefulWidget {
  const MyhomePage({super.key});

  @override
  State<MyhomePage> createState() => _MyhomePageState();
}

class _MyhomePageState extends State<MyhomePage> {
  final apiResponseController =
      Get.put(ApiResponseController(), permanent: true);

  @override
  void initState() {
    super.initState();
    isAndroidPermissionGranted();
    requestNotificationPermissions();
    loadMenuItem();
  }

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }

  Future<void> loadMenuItem() async {
    final response = await apiResponseController.fetchTopics();
    void updateSubtopic(Subtopic subTopic) {
      PreferenceService().saveSubtopic(subTopic);
    }

    bool isSubtopicUpdated(Subtopic savedSubtopic) {
      for (var item in response.menuItems ?? []) {
        for (var topic in item.topics ?? []) {
          for (var subTopic in topic.subtopics ?? []) {
            if (savedSubtopic.subTopicId == subTopic.subTopicId) {
              updateSubtopic(subTopic);
              return true;
            }
          }
        }
      }
      return false;
    }

    List<Subtopic> savedSubtopics = PreferenceService().loadNavbarItems();
    for (var savedSubtopic in savedSubtopics) {
      if (!isSubtopicUpdated(savedSubtopic)) {
        PreferenceService().removeSubtopic(savedSubtopic, false);
        SubtopicService().unsubscribeToSubtopic(savedSubtopic.subTopicId!);
      }
    }
    SubtopicNavController.to.menuUpdate();
  }
}
