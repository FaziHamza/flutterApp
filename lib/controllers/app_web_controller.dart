import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news/pages/next_page.dart';
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

  String _lastPageLink = '';
  String get lastPageLink => _lastPageLink;

  toggleLastLink(String link) {
    _lastPageLink = link;
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
    if(storage.read("isFirstTime") == true) {
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

  void initializeController() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    bottomBarItems = navController.getNavbarItems();

    if (controller.value.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.value.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
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
            print('this is on url navigation request :: $request');
            String scriptContent = await loadScript();
            controller.value.runJavaScript(scriptContent);
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) async {
            // Uri changeUrl = Uri.parse(change.url!);
            print('this is change url :: ${change.url}');
            if (change.url!.contains('isExternal')) {
              String url = change.url!;

              Uri uri = Uri.parse(url);

              // String host = uri.host; // 'sportblitznews.se'
              // String path = uri.path; // '/external'
              Map<String, String> queryParameters = uri.queryParameters;

              String articleLink = queryParameters['ArticleLink'].toString();

              String logo = queryParameters['Logo'] ?? '';
              String text = queryParameters['Text'] ?? ''; // 'hv71'
              Get.to(() => NextPage(
                    title: text,
                    url: articleLink,
                    logImage: logo,
                  ));
              controller.value.loadRequest(Uri.parse(_lastPageLink));
              return;
            } else {
              toggleLastLink(change.url!);
              String scriptContent = await loadScript();
              controller.value.runJavaScript(scriptContent);
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
        Uri.parse(bottomBarItems.isNotEmpty
            ? getLink(bottomBarItems[0].tooltip.toString())
            : navController.activeSubtopics.isNotEmpty
                ? 'https://sportblitznews.se/news/${navController.activeSubtopics[0].name!.toLowerCase().replaceAll(' ', '_')}_'
                : 'https://sportblitznews.se'),
      );
    update();
  }

  String getLink(String item) {
    String link = item;
    // int lenghtOfString = link.length;
    if (link[link.length - 1] == '_') {
      link = link.substring(0, link.length - 1);
    }
    toggleLastLink('https://sportblitznews.se/news/${link}');

    return 'https://sportblitznews.se/news/${link}';

    // AppWebController.to.controller.value.loadRequest(Uri.parse());
  }

  Future<String> loadScript() async {
    return await rootBundle.loadString('assets/style.js');
  }
}
