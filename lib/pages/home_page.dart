import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news/components/app_drawer.dart';
import 'package:news/controllers/app_web_controller.dart';
import 'package:news/models/News.dart';
import 'package:news/pages/bottom_navbar_section.dart';
import 'package:news/pages/next_page.dart';
import 'package:news/utils/ExpenseCard.dart';
import 'package:news/utils/NewsFirstCard.dart';
import 'package:news/utils/app_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/api_response_controller.dart';
import '../utils/app_color_swatch.dart';
import '../utils/drawer_controller.dart';
import '../utils/subtopic_navitem_controller.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key, this.isFirstTime = true,this.link=""});
  final bool isFirstTime;
  String? link;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final apiResponseController =
      Get.put(ApiResponseController(), permanent: true);

  final drawerController = Get.put(CustomDrawerController(), permanent: true);
  final storage = GetStorage();

  List<News> mNewsList = [];
  bool isLoading = true;
   String mCurrentKey = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_)async
    {
      print("ENTER HOME  ${AppWebController.to.url_link.value}");

      if (widget.isFirstTime) {
        AppWebController.to.initializeController(link:widget.link??"");
        final first = AppWebController.to.bottomBarItems.first;
        String mKey = extractValue(first.key!.toString());
        print('Clicked: $mKey');
        if(mCurrentKey != mKey){
            loadNewsData(mKey);
          }
        }
      WidgetsBinding.instance.addObserver(this);
    });
    Future.delayed(Duration(seconds: 2)).then((_)
    {
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  String _getBaseUrl() {
    if (Platform.isAndroid) {
      return AppConstants.androidBaseUrl;
    } else if (Platform.isIOS) {
      return AppConstants.iosBaseUrl;
    } else {
      return AppConstants.baseUrl;
    }
  }

  Future<void> loadNewsData(String mKeyword) async {
    mCurrentKey = mKeyword;
    setState(() {
      isLoading = true;
      mNewsList = [];
    });
  try {
    final response = await apiResponseController.fetchNews(keyword: mKeyword, lang: "sv", sport: "");
    setState(() {
      isLoading = false;
      mNewsList = response.news;
    });
  } catch (e) {
    setState(() {
      isLoading = false;
    });
    // Handle the error here
    print('Error loading news: $e');
  }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        print("App resumed......");
        final webAppController = Get.find<AppWebController>();
        String lastLink = webAppController.lastPageLink;
        if (lastLink == '') {
          lastLink = _getBaseUrl();
        }
        AppWebController.to.controller.value.loadRequest(Uri.parse(lastLink));
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        print("Application goes out side.....");
        break;
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: AppWebController.to.homeScaffoldKey,
      appBar:  AppBar(
        backgroundColor: const Color.fromARGB(255, 57, 67, 78),
        leading: Container(
          padding: const EdgeInsets.only(left :8.0), // Adjust the padding if necessary
          child: Image.asset(
            'assets/image/black_sport_news.png',
            height: 36.0,
            width: 200.0,
           // fit: BoxFit.contain, // Ensures the image fits within the given height and width
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: GetBuilder<AppWebController>(builder: (appWebController) {
              if (!appWebController.isShowBackButton) {
                return IconButton(
                  onPressed: () {
                    appWebController.homeScaffoldKey.currentState!.openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                );
              }
              return IconButton(
                onPressed: () {
                  appWebController.toogleBackButton(false);
                  appWebController.controller.value.loadRequest(Uri.parse(appWebController.lastPageLink));
                },
                icon: const Icon(Icons.arrow_back),
              );
            }),
          ),
        ],
      ),
      drawer: AppDrawer().getAppDrawer(),
      body: Center(
        child: isLoading
          ? const CircularProgressIndicator()
          : NewsList(mNewsList: mNewsList)
          // ListView.builder(
          //   itemCount: mNewsList.length,
          //   itemBuilder: (context, index) {
          //       final item = mNewsList[index];
          //       return GestureDetector(
          //         onTap: (){
          //           String artical = item.articleLink.toString();
          //           if(artical != "null" && artical.isNotEmpty){
          //               Get.to(() => NextPage(
          //                 title: item.title.toString(),
          //                 url: item.articleLink.toString(),
          //                 logImage: item.generalistProfile.toString(),
          //               ));
          //           }  
          //         },
          //         child:  NewsFirstCard(
          //           imageUrl: item.medias![1].href.toString(),
          //           title: item.title.toString(),
          //           details: item.content.toString(),
          //           groupName: item.generalistName.toString(),
          //           postTime: item.published != null ? DateTime.now() : item.published!,
          //         ),
          //       );
          //   },
          // )
      ),
     bottomNavigationBar: BottomNavbarSection(
      onClick: (value) {
        String mKey = extractValue(value.key!.toString());
        print('Clicked: $mKey');
        
        if(mCurrentKey != mKey){
            loadNewsData(mKey);
          }
        },
      ),
    );
  }

  String extractValue(String input) {
    int startIndex = input.indexOf('<');
    int endIndex = input.indexOf('>');
    if (startIndex != -1 && endIndex != -1 && endIndex > startIndex) {
      return input.substring(startIndex + 2, endIndex-1);
    } else {
      return ""; 
    }
  }


  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     key: AppWebController.to.homeScaffoldKey,

  //     appBar: AppBar(
  //       // backgroundColor: AppColorSwatch.appBarColor,

  //       backgroundColor: Color.fromARGB(255, 57, 67, 78),
  //       leading: GetBuilder<AppWebController>(builder: (appWebController) {
  //         if (appWebController.isShowBackButton == false) {
  //           return IconButton(
  //               onPressed: () {
  //                 appWebController.homeScaffoldKey.currentState!.openDrawer();
  //               },
  //               icon: const Icon(Icons.menu));
  //           // AppDrawer().getAppDrawer();
  //         }
  //         return IconButton(
  //             onPressed: () {
  //               // Get.back();
  //               appWebController.toogleBackButton(false);

  //               appWebController.controller.value
  //                   .loadRequest(Uri.parse('${appWebController.lastPageLink}'));

  //               // final SubtopicNavController navController = Get.find();
  //               // navController.toggleSelectedNavItem(0);
  //               // Get.offAll(
  //               //   () => HomePage(
  //               //     isFirstTime: true,
  //               //   ),
  //               // );
  //             },
  //             icon: const Icon(Icons.arrow_back));
  //       }),
  //       title: Image.asset(
  //         'assets/image/logo.png',
  //         height: 36.0,
  //       ),
  //       centerTitle: true,
  //       actions: [
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //           child: SvgPicture.asset(
  //             'assets/image/sweden.svg',
  //             height: 36.0,
  //             width: 36.0,
  //           ),
  //         ),
  //       ],
  //     ),
  //     drawer: AppDrawer().getAppDrawer(),

  //     //  GetBuilder<AppWebController>(
  //     //    builder: (appWebController) {
  //     //     if(appWebController.isShowBackButton.value == true){
  //     //       return SizedBox() ;
  //     //     }
  //     //      return AppDrawer().getAppDrawer();
  //     //    }
  //     //  ),
  //     body: Center(
  //       child: WillPopScope(
  //         onWillPop: () async {
  //           bool canGoBack =
  //               await AppWebController.to.controller.value.canGoBack();
  //           if (canGoBack) {
  //             AppWebController.to.controller.value.goBack();
  //             return false; // Prevent app from exiting
  //           } else {
  //             return true; // Allow app to exit
  //           }
  //         },
  //         child: GetBuilder<SubtopicNavController>(builder: (navController) {
  //           // var items = navController.getNavbarItems(); // Corrected variable name to plural
  //           // if (items.isEmpty) {
  //           //   final appWebContr = AppWebController.to.controller;
  //           //     appWebContr.toggleLastLink(_getBaseUrl());
  //           //     appWebContr.controller.value.loadRequest(Uri.parse(_getBaseUrl()));
  //           //     return WebViewWidget(controller: appWebContr.controller.value);
  //           // }
  //           return WebViewWidget(
  //               controller: AppWebController.to.controller.value
  //           );
  //         }),
  //       ),
  //     ),
  //     bottomNavigationBar: const BottomNavbarSection(),

  //     // Obx(() {
  //     //   var items = navController.getNavbarItems();
  //     //   if (items.isEmpty) {
  //     //     return const SizedBox.shrink();
  //     //   }
  //     //   return Container(
  //     //     decoration: BoxDecoration(
  //     //       color: AppColorSwatch.customBlack[50],
  //     //     ),
  //     //     height: 56.0,
  //     //     child: SingleChildScrollView(
  //     //       scrollDirection: Axis.horizontal,
  //     //       child: Row(
  //     //         children: items
  //     //             .map((item) =>
  //     //                 BottomNavigationBarItemWidget(item, items.indexOf(item)))
  //     //             .toList(),
  //     //       ),
  //     //     ),
  //     //   );
  //     // }), // No navbar if no active subtopics
  //   );
  // }

}

// old code
// class HomePage extends GetView<AppWebController> {
//   final bool isFirstTime;
//   final apiResponseController =
//       Get.put(ApiResponseController(), permanent: true);

//   final drawerController = Get.put(CustomDrawerController(), permanent: true);
//   // final SubtopicNavController navController =
//   //     Get.put(SubtopicNavController(), permanent: true);

//   HomePage({super.key, this.isFirstTime = true});

//   @override
//   Scaffold build(BuildContext context) {
//     if (isFirstTime) {
//       AppWebController.to.initializeController();
//     }

//     return Scaffold(
//       key: AppWebController.to.homeScaffoldKey,
//       appBar: AppBar(
//         backgroundColor: AppColorSwatch.appBarColor,
//         leading: isFirstTime
//             ? null
//             : IconButton(
//                 onPressed: () {
//                   Get.back();
//                 },
//                 icon: Icon(Icons.arrow_back)),
//         title: Image.asset(
//           'assets/image/logo.png',
//           height: 36.0,
//         ),
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12.0),
//             child: SvgPicture.asset(
//               'assets/image/sweden.svg',
//               height: 36.0,
//               width: 36.0,
//             ),
//           ),
//         ],
//       ),
//       drawer: AppDrawer().getAppDrawer(),
//       body: Center(
//         child: WillPopScope(
//           onWillPop: () async {
//             bool canGoBack =
//                 await AppWebController.to.controller.value.canGoBack();
//             if (canGoBack) {
//               AppWebController.to.controller.value.goBack();
//               return false; // Prevent app from exiting
//             } else {
//               return true; // Allow app to exit
//             }
//           },
//           child: WebViewWidget(
//             controller: AppWebController.to.controller.value,
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavbarSection(),

//       // Obx(() {
//       //   var items = navController.getNavbarItems();
//       //   if (items.isEmpty) {
//       //     return const SizedBox.shrink();
//       //   }
//       //   return Container(
//       //     decoration: BoxDecoration(
//       //       color: AppColorSwatch.customBlack[50],
//       //     ),
//       //     height: 56.0,
//       //     child: SingleChildScrollView(
//       //       scrollDirection: Axis.horizontal,
//       //       child: Row(
//       //         children: items
//       //             .map((item) =>
//       //                 BottomNavigationBarItemWidget(item, items.indexOf(item)))
//       //             .toList(),
//       //       ),
//       //     ),
//       //   );
//       // }), // No navbar if no active subtopics
//     );
//   }
// }

// Widget for each item in the scrollable bottom navigation bar
