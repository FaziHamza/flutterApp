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
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      final bool isDarkMode = _themeMode == ThemeMode.dark ||
          (_themeMode == ThemeMode.system &&
              WidgetsBinding.instance.window.platformBrightness == Brightness.dark);

      AppController.to.setIsDark(isDarkMode);
    });
  }

  void onDispose() {
    Hive.close();
  }

  @override
  void initState() {
    super.initState();
    final bool isDarkMode = _themeMode == ThemeMode.dark ||
        (_themeMode == ThemeMode.system &&
            WidgetsBinding.instance.window.platformBrightness == Brightness.dark);

    AppController.to.setIsDark(isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    widget.apiResponseController.fetchTopics();
    Get.put(SubtopicNavController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SportBlitz News',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColorSwatch.bgContainerColorLight,
        extensions: <ThemeExtension<dynamic>>[
          CustomColors(
            cardColor: AppColorSwatch.cardColorLight,
            topBarColor: AppColorSwatch.topBarColorLight,
            bgContainerColor: AppColorSwatch.bgContainerColorLight,
            bgBarColor: AppColorSwatch.bgBarColorLight,
            iconTextColor: AppColorSwatch.iconTextColorLight,
            titleTextColor: AppColorSwatch.titleTextColorLight,
            switchColor: AppColorSwatch.switchColorLight,
            badgeColor: AppColorSwatch.badgeColorLight,
            badgeTextColor: AppColorSwatch.badgeTextColorLight,
            sitesCardColor: AppColorSwatch.siteCardColorLight,
            cardItemColor: AppColorSwatch.cardItemColorLight,
            lineItemColor: AppColorSwatch.lineItemColorLight,
          ),
        ],
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColorSwatch.bgContainerColorDark,
        extensions: <ThemeExtension<dynamic>>[
          CustomColors(
            cardColor: AppColorSwatch.cardColorDark,
            topBarColor: AppColorSwatch.topBarColorDark,
            bgContainerColor: AppColorSwatch.bgContainerColorDark,
            bgBarColor: AppColorSwatch.bgBarColorDark,
            iconTextColor: AppColorSwatch.iconTextColorDark,
            titleTextColor: AppColorSwatch.titleTextColorDark,
            switchColor: AppColorSwatch.switchColorDark,
            badgeColor: AppColorSwatch.badgeColorDark,
            badgeTextColor: AppColorSwatch.badgeTextColorDark,
            sitesCardColor: AppColorSwatch.siteCardColorDark,
            cardItemColor: AppColorSwatch.cardItemColorDark,
            lineItemColor: AppColorSwatch.lineItemColorDark,
          ),
        ],
      ),
      themeMode: _themeMode,
      onDispose: onDispose,
      home: MyHomePage(
          isLightMode: _themeMode == ThemeMode.light ||
              (_themeMode == ThemeMode.system &&
                  WidgetsBinding.instance.window.platformBrightness == Brightness.light),
          onTap: () {
            _toggleTheme();
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final GestureTapCallback onTap;
  final bool isLightMode;

  const MyHomePage({super.key, required this.isLightMode, required this.onTap});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    return HomePage(
      isLightMode: widget.isLightMode,
      onTap: widget.onTap,
    );
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
