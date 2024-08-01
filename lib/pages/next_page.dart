// import 'package:facebook_app_events/facebook_app_events.dart';
import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:news/controllers/app_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/CustomColors.dart';

class NextPage extends StatefulWidget {
  final String title;
  final String logImage;
  final String url;
  final String? oldUrl;
  final bool hideBar;

  const NextPage({
    super.key,
    required this.title,
    required this.url,
    required this.logImage,
    this.hideBar = false,
    this.oldUrl = "",
  });

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  late final WebViewController controller;

  String imageLink = '';
  String oldUrl = '';

  setImageLink() {
    try {
      if (kDebugMode) {
        print('this is loading url :: ${widget.url}');
        print('this is image Logo ::${widget.logImage}');
      }
      if (widget.logImage.isNotEmpty) {
        if (widget.logImage[widget.logImage.length - 1] == '/') {
          imageLink = widget.logImage.substring(0, widget.logImage.length - 1);
        }
      }
    } on Exception {
      if (kDebugMode) {
        print("Error");
      }
    }
  }

  bool isLoading = false;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    super.initState();
    oldUrl = widget.oldUrl.toString();

    analytics.logEvent(
      name: 'pages_tracked',
      parameters: {
        'page_name': 'External Page',
      },
    );

    setImageLink();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (request) async {
            if (GetPlatform.isAndroid) {
              Get.to(
                () => NextPage(
                    title: widget.title,
                    oldUrl: widget.url,
                    url: request.url,
                    logImage: widget.logImage),
                preventDuplicates: false,
              );
              return NavigationDecision.prevent;
            } else if (GetPlatform.isIOS) {
              if (kDebugMode) {
                print('request url ==== ${request.url}');
              }
              if (request.url.contains('fotbolldirekt.se/') ||
                  request.url.contains('https://online.equipe.com/') ||
                  request.url.contains('https://ridsport.se/') ||
                  request.url.contains('https://www.scorebat.com/') ||
                  request.url.contains('https://fotbolldirekt.se/') ||
                  request.url
                      .contains('https://online-uploads.equipeassets.com/') ||
                  request.url.contains('https://www.fotbollskanalen.se/')) {
                log('this request condition is true :: ${request.url}');
                await Future.delayed(
                  const Duration(milliseconds: 500),
                );

                if (widget.oldUrl != widget.url && oldUrl != "") {
                  Get.to(
                    () => NextPage(
                      title: widget.title,
                      oldUrl: "",
                      // widget.url,
                      url: request.url.toString(),
                      logImage: widget.logImage,
                    ),
                    preventDuplicates: false,
                  );
                  return NavigationDecision.prevent;
                } else {
                  oldUrl = widget.url;

                  return NavigationDecision.navigate;
                }
              }
            } else {
              Get.to(
                () => NextPage(
                  title: widget.title,
                  url: request.url,
                  logImage: widget.logImage,
                ),
                preventDuplicates: false,
              );
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
            // return;
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(updateThemeParameter(widget.url)));
  }

  String updateThemeParameter(String url) {
    Uri uri = Uri.parse(url);
    String theme = AppController.to.getIsDark() ? 'Dark' : 'Light';
    Uri updatedUri = uri.replace(
      queryParameters: {...uri.queryParameters, 'theme': theme},
    );
    return updatedUri.toString();
  }

  @override
  Widget build(BuildContext context) {
    return widget.hideBar ? custom(context) : defaultView(context);
  }

  Widget defaultView(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Scaffold(
      backgroundColor: customColors.bgContainerColor,
      body: Column(
        children: [
          Container(
            color: customColors.topBarColor,
            alignment: Alignment.bottomCenter,
            height: 85.0,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Image.asset(
                  'assets/image/black_sport_news.png',
                  height: 36.0,
                ),
                SvgPicture.asset(
                  'assets/image/sweden.svg',
                  height: 36.0,
                  width: 36.0,
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : WebViewWidget(controller: controller),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: customColors.bgBarColor,
        child: ((widget.title == '' && widget.logImage == '') ||
                (widget.title == 'null' && widget.logImage == 'null'))
            ? const Row(children: [])
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32.0)),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            if (widget.logImage != 'null' &&
                                widget.logImage != '')
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  widget.logImage,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              (widget.title == '' || widget.title == 'null')
                                  ? '--'
                                  : widget.title,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget custom(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Scaffold(
      backgroundColor: customColors.bgContainerColor,
      body: Stack(
        children: [
          // WebView
          Positioned.fill(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : WebViewWidget(
                    controller: controller,
                  ),
          ),
          // Custom top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
            color: customColors.topBarColor,
              // Slight transparency
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              height: 85.0,
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Image.asset(
                    'assets/image/black_sport_news.png',
                    height: 36.0,
                  ),
                  SvgPicture.asset(
                    'assets/image/sweden.svg',
                    height: 36.0,
                    width: 36.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color(0xff262626),
        child: ((widget.title == '' && widget.logImage == '') ||
                (widget.title == 'null' && widget.logImage == 'null'))
            ? const Row(children: [])
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, bottom: 12, top: 8),
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32.0)),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: <Widget>[
                            if (widget.logImage != 'null' &&
                                widget.logImage != '')
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  widget.logImage,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              (widget.title == '' || widget.title == 'null')
                                  ? '--'
                                  : widget.title,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
