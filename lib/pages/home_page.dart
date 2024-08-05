import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news/components/app_drawer.dart';
import 'package:news/models/News.dart';
import 'package:news/models/api_highlights_response.dart';
import 'package:news/models/api_response_controller.dart';
import 'package:news/models/api_today_hilights_response.dart';
import 'package:news/models/my_pod_cast_response.dart';
import 'package:news/models/my_sites_reponse.dart';
import 'package:news/models/my_video_hiegh_response.dart';
import 'package:news/models/subtopic.dart';
import 'package:news/pages/bottom_navbar_section.dart';
import 'package:news/pages/news_main_page.dart';

import '../controllers/app_controller.dart';
import '../utils/CustomColors.dart';
import '../utils/drawer_controller.dart';
import '../utils/subtopic_navitem_controller.dart';

class HomePage extends StatefulWidget {
  bool isFirstTime;
  String? link;
  final GestureTapCallback onTap;
  final bool isLightMode;

  HomePage(
      {super.key,
      this.isFirstTime = true,
      this.link = "",
      required this.isLightMode,
      required this.onTap});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final apiResponseController =
      Get.put(ApiResponseController(), permanent: true);

  final drawerController = Get.put(CustomDrawerController(), permanent: true);
  final storage = GetStorage();
  bool isLoading = true;
  String mCurrentKey = "";
  final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();
  NewListIte mNewListIte = NewListIte(
      mHeader: '',
      mNewsList: [],
      mHighlights: [],
      mHilightsList: [],
      mMySiteList: [],
      mPodCastList: [],
      todayHighLights: const []);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      storage.writeIfNull("isFirstTime", true);
      storage.writeIfNull("showNotification", true);
      if (storage.read("isFirstTime") == true) {
        homeScaffoldKey.currentState!.openDrawer();
      }
      if (widget.isFirstTime) {
        final first = SubtopicNavController.to.getNavbarItems().first;
        Subtopic subtopic = Subtopic.fromRawJson(first.tooltip ?? '');
        SubtopicNavController.to.mItem.value = [subtopic];
        if (mCurrentKey != subtopic.keyword) {
          loadNewsData(subtopic);
        }
        widget.isFirstTime = false;
      }
      WidgetsBinding.instance.addObserver(this);
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    apiResponseController.cancelAllRequests();
  }

  Future<void> loadNewsData(Subtopic subtopic) async {
    mCurrentKey = subtopic.keyword ?? '';

    List<News> mNewsList = [];
    List<MySite> mMySiteList = [];
    List<PodCast> mPodCastList = [];
    List<Hilights> mHilightsList = [];
    List<HighLights> mHighlights = [];
    List<TodayHilights> todayHighLights = [];

    setState(() {
      isLoading = true;
      apiResponseController.cancelAllRequests();
      mNewListIte = NewListIte(
          mHeader: mCurrentKey,
          mNewsList: mNewsList,
          mHighlights: mHighlights,
          mHilightsList: mHilightsList,
          mMySiteList: mMySiteList,
          mPodCastList: mPodCastList,
          todayHighLights: const []);
    });
    try {
      final responseNews = await apiResponseController.fetchNews(
          keyword: mCurrentKey, lang: "sv", sport: "");
      setState(() {
        isLoading = false;
        mNewsList = responseNews.news;
        mNewListIte = NewListIte(
            mHeader: mCurrentKey,
            mNewsList: mNewsList,
            mHighlights: mHighlights,
            mHilightsList: mHilightsList,
            mMySiteList: mMySiteList,
            mPodCastList: mPodCastList,
            todayHighLights: todayHighLights);
      });
      final responseSites = await apiResponseController.fetchMySites(
          subtopicId: subtopic.subTopicId ?? '');
      mMySiteList = responseSites.data;

      if (subtopic.isSubtopicVideo == null ||
          subtopic.isSubtopicVideo == true) {
        final responseHigh = await apiResponseController.fetchMyHilights(
            subtopicId: subtopic.subTopicId ?? '');
        mHilightsList = responseHigh.news;
      } else {
        final responseHigh = await apiResponseController.fetchHilights(
            type: subtopic.highlightType ?? '',
            subtopic: subtopic.highlights ?? '');
        mHighlights = responseHigh.data;
      }
      final responsePod = await apiResponseController.fetchMyPodCast(
          subtopicId: subtopic.subTopicId ?? '');
      final responseToday = await apiResponseController.fetchTodayHigh(
          keyword: mCurrentKey, lang: "sv", sport: "");
      setState(() {
        mPodCastList = responsePod.data;
        todayHighLights = responseToday.news;
        mNewListIte = NewListIte(
            mHeader: mCurrentKey,
            mNewsList: mNewsList,
            mHighlights: mHighlights,
            mHilightsList: mHilightsList,
            mMySiteList: mMySiteList,
            mPodCastList: mPodCastList,
            todayHighLights: todayHighLights);
      });
    } catch (e) {
      // Handle the error here
      if (kDebugMode) {
        print('Error loading news: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      key: homeScaffoldKey,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10),
            alignment: Alignment.bottomCenter,
            height: 85.0,
            // Height of your custom app bar
            decoration: BoxDecoration(
              color: customColors.topBarColor, // Background color
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  offset: Offset(0, 3), // Shadow offset
                  blurRadius: 10, // Blur radius
                  spreadRadius: 0, // Spread radius
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(AppController.to.getIsDark()
                    ? 'assets/image/black_sport_news.png'
                    : 'assets/image/app_light_icon.png'),
                IconButton(
                  onPressed: () {
                    homeScaffoldKey.currentState!.openDrawer();
                  },
                  icon: Icon(Icons.menu, color: customColors.titleTextColor),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : MainNewsList(mNewListIte: mNewListIte)),
          ),
        ],
      ),
      drawer: AppDrawer().getAppDrawer(
        widget.isLightMode,
        customColors,
        (value) {
          String mKey = value.keyword ?? '';
          if (mCurrentKey != mKey) {
            loadNewsData(value);
          }
        },
        (value) {
          if (storage.read("showNotification") == true) {
            storage.write("showNotification", false);
            storage.write("isFirstTime", false);
          }
          Navigator.pop(context);
        },
        widget.onTap,
      ),
      bottomNavigationBar: BottomNavbarSection(
        onClick: (value) {
          Subtopic subtopic = Subtopic.fromRawJson(value.tooltip ?? '');
          if (mCurrentKey != subtopic.keyword && subtopic.keyword != null) {
            loadNewsData(subtopic);
          }
        },
      ),
    );
  }
}
