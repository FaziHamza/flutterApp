
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news/components/app_drawer.dart';
import 'package:news/controllers/app_web_controller.dart';
import 'package:news/pages/bottom_navbar_section.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/api_response_controller.dart';
import '../utils/app_color_swatch.dart';
import '../utils/drawer_controller.dart';
import '../utils/subtopic_navitem_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.isFirstTime = true});
  final bool isFirstTime;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final apiResponseController =
      Get.put(ApiResponseController(), permanent: true);

  final drawerController = Get.put(CustomDrawerController(), permanent: true);
  final storage = GetStorage();

  @override
  void initState() {
    super.initState();
    if (widget.isFirstTime) {
      AppWebController.to.initializeController();
    }
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.resumed:
      print("App resumed......");
       final webAppController = Get.find<AppWebController>();
    String lastLink = webAppController.lastPageLink;
    // webAppController.controller.value.
    AppWebController.to.controller.value.loadRequest(Uri.parse(lastLink
        // 'https://sportblitznews.se/news/${link}'
        ));
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
      appBar: AppBar(
        backgroundColor: AppColorSwatch.appBarColor,
        // leading: widget.isFirstTime
        //     ? null
        //     : IconButton(
        //         onPressed: () {
        //           // Get.back();
        //           final SubtopicNavController navController = Get.find();
        //           navController.toggleSelectedNavItem(0);
        //           Get.offAll(
        //             () => HomePage(
        //               isFirstTime: true,
        //             ),
        //           );
        //         },
        //         icon: Icon(Icons.arrow_back)),
        title: Image.asset(
          'assets/image/logo.png',
          height: 36.0,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SvgPicture.asset(
              'assets/image/sweden.svg',
              height: 36.0,
              width: 36.0,
            ),
          ),
        ],
      ),
      drawer: AppDrawer().getAppDrawer(),
      body: Center(
        child: WillPopScope(
          onWillPop: () async {
            bool canGoBack =
                await AppWebController.to.controller.value.canGoBack();
            if (canGoBack) {
              AppWebController.to.controller.value.goBack();
              return false; // Prevent app from exiting
            } else {
              return true; // Allow app to exit
            }
          },
          child: 
          
          GetBuilder<SubtopicNavController>(
            builder: (navController) {
              var item = navController.getNavbarItems();
              if(item.isEmpty) {
                return
                
                Center(child: Text("No option is selected"),);
              }
              return WebViewWidget(
                controller: AppWebController.to.controller.value,
              );
            }
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbarSection(),

      // Obx(() {
      //   var items = navController.getNavbarItems();
      //   if (items.isEmpty) {
      //     return const SizedBox.shrink();
      //   }
      //   return Container(
      //     decoration: BoxDecoration(
      //       color: AppColorSwatch.customBlack[50],
      //     ),
      //     height: 56.0,
      //     child: SingleChildScrollView(
      //       scrollDirection: Axis.horizontal,
      //       child: Row(
      //         children: items
      //             .map((item) =>
      //                 BottomNavigationBarItemWidget(item, items.indexOf(item)))
      //             .toList(),
      //       ),
      //     ),
      //   );
      // }), // No navbar if no active subtopics
    );
  }
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
