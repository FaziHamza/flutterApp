import 'dart:developer';

// import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news/pages/next_page.dart';
import 'package:news/pages/potcast_page.dart';
import 'package:news/utils/app_constants.dart';
import 'package:news/utils/subtopic_navitem_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../utils/app_color_swatch.dart';

class AppWebController extends GetxController {
  static AppWebController get to => Get.put(AppWebController());
  SubtopicNavController navController = Get.find();
  final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();

  Rx<WebViewController> controller = WebViewController().obs;

  Rx<WebViewController> detailController = WebViewController().obs;

  String _lastPageLink = '';
  String get lastPageLink => _lastPageLink;
  var url_link="".obs;

  bool _isShowBackButton = false;
  bool get isShowBackButton => _isShowBackButton;

  toggleLastLink(String link) {
    _lastPageLink = link;
    update();
  }

  toogleBackButton(bool value) {
    _isShowBackButton = value;
    update();
  }

  @override
  void onInit() {
    _onDrawerClose();
    super.onInit();
  }

  @override
  void onClose() {
    _onDrawerClose();
    super.onClose();
  }

  @override
  void onReady() {
    _onDrawerClose();
    findItem();
    super.onReady();
  }

  findItem() {
    final storage = GetStorage();
    storage.writeIfNull("isFirstTime", true);
    if (storage.read("isFirstTime") == true) {
      homeScaffoldKey.currentState?.openDrawer();
    }
    storage.write("isFirstTime", false);
    // var items = navController.getNavbarItems();
    // if (items.isEmpty || items[0].label == null) {
    //   SubtopicNavController subtopicNavController =
    //       Get.find<SubtopicNavController>();
    //   subtopicNavController.toggleSaveButton(true);
    //   homeScaffoldKey.currentState?.openDrawer();
    // } else {}
  }

  void _onDrawerClose() {
    if (homeScaffoldKey.currentState != null &&
        !homeScaffoldKey.currentState!.isDrawerOpen) {
      AppWebController.to.controller.value.reload();
    }
    update();
  }

  List<BottomNavigationBarItem> bottomBarItems = [];
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void initializeController({String link=""}) {
    print("LINK LINK ${link!=""}    link ${link}");
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    bottomBarItems = navController.getNavbarItems([]);

    if (controller.value.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);

      (controller.value.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(true);
    }

    controller.value = WebViewController.fromPlatformCreationParams(params);

    controller.value
      ..setUserAgent("MyCustomWebViewMarker")
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColorSwatch.customBlack)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) async {
            debugPrint('WebView is loading (progress : $progress%)');
            String scriptContent = await loadScript();
            // if(scriptContent.)
            controller.value.runJavaScript(scriptContent);
          },
          onPageStarted: (String url) async {
            debugPrint('Page started loading: $url');
            String scriptContent = await loadScript();
            controller.value.runJavaScript(scriptContent);
          },
          onPageFinished: (String url) async {
            debugPrint('Page finished loading: $url');
            String scriptContent = await loadScript();
            controller.value.runJavaScript(scriptContent);
          },
          onNavigationRequest: (NavigationRequest request) async {
            print('this is on url navigation request :: ${request.url}');
            String scriptContent = await loadScript();
            controller.value.runJavaScript(scriptContent);
            // if (request.url.contains("isExternal")) {
            //   return NavigationDecision.prevent;
            // }
            // if (GetPlatform.isIOS) {
            //   return NavigationDecision.prevent;
            // }

            return NavigationDecision.navigate;
          },
          onWebResourceError: (error) {
            print('this is error: ${error.description}');
            controller.value.loadRequest(Uri.parse(error.url!));
          },
          onUrlChange: (UrlChange change) async {
            if (change.url == null) {
              return;
            }
            // Uri changeUrl = Uri.parse(change.url!);
            String url = change.url.toString();

            Uri uri = Uri.parse(url);
            print("this is uri of the link ::: $uri");
            debugPrint("hello world this is uri link :: $uri");
            log("hello world this is log of uri ::: $uri");


            if (change.url!.contains('isExternal')) {
              analytics.logEvent(
                name: 'pages_tracked',
                parameters: {
                  'page_name': 'External Link Page',
                },
              );
              // FacebookAppEvents().logEvent(
              //   name: "Home Screen",
              //   parameters: {
              //     "page_name": "External Link Page",
              //   },
              // );
              String url = change.url!;

              Uri uri = Uri.parse(url);
              print("this is uri of the link ::: $uri");
              debugPrint("hello world this is uri link :: $uri");
              log("hello world this is log of uri ::: $uri");

              // String host = uri.host; // 'sportblitznews.se'
              // String path = uri.path; // '/external'
              Map<String, String> queryParameters = uri.queryParameters;
              print("this is query parameteres ::: $queryParameters");

              String articleLink = queryParameters['ArticleLink'].toString();

              String logo = queryParameters['Logo'] ?? '';
              String text = queryParameters['Text'] ?? ''; // 'hv71'

              if (articleLink.endsWith('//')) {
                articleLink = articleLink.substring(0, articleLink.length - 1);
              }

              // AdHelper.showInterstitialAd(() {
              //   Get.to(() => NextPage(
              //         title: text,
              //         url: articleLink,
              //         logImage: logo,
              //       ));
              // });
              Get.to(() => NextPage(
                    title: text,
                    url: articleLink,
                    logImage: logo,
                  ));

              controller.value.loadRequest(Uri.parse(_lastPageLink));
              return;
            } else {
              Uri uria = Uri.parse(change.url.toString());

              if (uria.pathSegments.length > 2) {
                toogleBackButton(true);
              } else if ((uria.path).contains("videohighlights") ||
                  (uria.path).contains("highlights") ||
                  (uria.path).contains("podcast")) {
                if ((uria.path).contains("podcast")) {
                  String? subtopicId = uri.queryParameters['subtopicid'];
                  print("subtopicId ::: $subtopicId");
                  debugPrint("subtopicId :: $subtopicId");
                  log("subtopicId ::: $subtopicId");

                  // Navigate to the PodcastPage with subtopicId
                  if (subtopicId != null) {
                    Get.to(() => PodcastPage(
                        subtopicId: subtopicId, title: _lastPageLink));
                    controller.value.loadRequest(Uri.parse(_lastPageLink));
                    return;
                  } else {
                    toogleBackButton(true);
                  }
                } else {
                  toogleBackButton(true);
                }
              } else {
                analytics.logEvent(
                  name: 'pages_tracked',
                  parameters: {
                    'page_name': 'Home Page',
                  },
                );
                // FacebookAppEvents().logEvent(
                //   name: "Home Screen",
                //   parameters: {
                //     "page_name": "Home Page",
                //   },
                // );

                toggleLastLink(change.url!);
                String scriptContent = await loadScript();
                if (change.url!.contains("/show/") ||
                    change.url!.contains("spotify.com") ||
                    (change.url!).contains("/embed/")) {
                } else {
                  controller.value.runJavaScript(scriptContent);
                }
              }
            }
          },
          onHttpAuthRequest: (HttpAuthRequest request) async {
            print('this is on url request :: $request');
            String scriptContent = await loadScript();
            controller.value.runJavaScript(scriptContent);
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
            //"https://www.sportblitznews.se/news/notify/34HM9FK"
            link!=""?"https://www.sportblitznews.se/news/notify/34HM9FK":bottomBarItems.isNotEmpty
            ? getLink(bottomBarItems[0].tooltip.toString())
            : _getBaseUrl()
        ),
      );
    update();
  }


  String _getBaseUrl() {
    if (GetPlatform.isAndroid) {
      return AppConstants.androidBaseUrl;
    } else if (GetPlatform.isIOS) {
      return AppConstants.iosBaseUrl;
    } else {
      return AppConstants.baseUrl;
    }
  }

  String getLink(String item) {
    String link = item;
    // int lenghtOfString = link.length;
    if (link[link.length - 1] == '_') {
      link = link.substring(0, link.length - 1);
    }
    toggleLastLink('${AppConstants.baseUrl}/news/${link}');
    print("this is link ;;;; ${link}");
    return '${AppConstants.baseUrl}/news/${link}';

    // AppWebController.to.controller.value.loadRequest(Uri.parse());
  }

  Future<String> loadScript() async {
    return await rootBundle.loadString('assets/style.js');
  }
}
