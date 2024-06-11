// import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/app_color_swatch.dart';
import 'bottom_navbar_section.dart';

class NextPage extends StatefulWidget {
  final String title;
  final String logImage;
  final String url;
  final String? oldUrl;
  const NextPage({
    super.key,
    required this.title,
    required this.url,
    required this.logImage,
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
    print('this is image Logo ::${widget.logImage}');
    if (widget.logImage[widget.logImage.length - 1] == '/') {
      imageLink = widget.logImage.substring(0, widget.logImage.length - 1);
    }
    // setState(() {
    //   imageLink = widget.logImage;
    // });
  }

  bool isLoading = false;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    super.initState();
    oldUrl = widget.oldUrl.toString();
    // analytics.logEvent(
    //   name: 'pages_tracked',
    //   parameters: {
    //     'page_name': 'External Link Page',
    //   },
    // );
    analytics.logEvent(
      name: 'pages_tracked',
      parameters: {
        'page_name': 'External Page',
      },
    );
    // FacebookAppEvents().logEvent(
    //   name: "Home Screen",
    //   parameters: {
    //     "page_name": "External Page",
    //   },
    // );
    // FacebookAppEvents().logAdImpression(adType: "External Page Impression");
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

          // onUrlChange: (change) {
          //   print("this is next page change url :: ${change.url}");

          // },

          onNavigationRequest: (request) async {
            if (GetPlatform.isAndroid) {
              // if (widget.oldUrl != widget.url && oldUrl != "") {
              // }
              Get.to(
                () => NextPage(
                    title: widget.title,
                    oldUrl: widget.url,
                    url: request.url,
                    logImage: widget.logImage),
                preventDuplicates: false,
              );
              return NavigationDecision.prevent;
              // return NavigationDecision.navigate;
            } else if (GetPlatform.isIOS) {
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
                      logImage: widget.logImage),
                  preventDuplicates: false,
                  // widget.oldUrl == widget.url ? true : false,
                );
                return NavigationDecision.prevent;
              } else {
                oldUrl = widget.url;

                return NavigationDecision.navigate;
              }
            }
            return NavigationDecision.navigate;
            // return;
          },
          onWebResourceError: (WebResourceError error) {},
          // onNavigationRequest: (NavigationRequest request) {
          //   if (request.url.startsWith('https://www.youtube.com/')) {
          //     return NavigationDecision.prevent;
          //   }
          //   return NavigationDecision.navigate;
          // },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  // @override
  // void dispose() {
  //   final webAppController = Get.find<AppWebController>();
  //   String lastLink = webAppController.lastPageLink;
  //   // webAppController.controller.value.
  //   AppWebController.to.controller.value.loadRequest(Uri.parse(lastLink
  //       // 'https://sportblitznews.se/news/${link}'
  //       ));
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 57, 67, 78),
        // backgroundColor: AppColorSwatch.appBarColor,
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : WebViewWidget(controller: controller),
      // bottomNavigationBar: ,
      bottomNavigationBar: Container(
        // color: AppColorSwatch.appBarColor,
        color: Color.fromARGB(255, 57, 67, 78),
        child: ((widget.title == '' && widget.logImage == '') ||
                (widget.title == 'null' && widget.logImage == 'null'))
            ? BottomNavbarSection(onClick: (valu) {
                print("this is the value of on click on next screen:_ $valu");
                if (valu) {
                  Navigator.pop(context);
                }
              })
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(32.0)),
                          border: Border.all(color: Colors.white)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            // item.icon,
                            if (widget.logImage != 'null' &&
                                widget.logImage != '')
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  imageLink,
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
      // BottomNavbarSection()
    );
  }
}
