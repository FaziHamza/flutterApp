import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter_svg/svg.dart';

import '../utils/app_color_swatch.dart';
import 'bottom_navbar_section.dart';

class SpotifyCompainWidget extends StatefulWidget {
  final String title;
  final String logImage;
  final String url;
  final String compainName;
  const SpotifyCompainWidget(
      {super.key,
      required this.title,
      required this.url,
      required this.logImage,
      required this.compainName,
      });

  @override
  State<SpotifyCompainWidget> createState() => _SpotifyCompainWidgetState();
}

class _SpotifyCompainWidgetState extends State<SpotifyCompainWidget> {
  late final WebViewController controller;

  String imageLink = '';

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
  // FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    super.initState();
    // analytics.logEvent(
    //   name: 'pages_tracked',
    //   parameters: {
    //     'page_name': 'External Link Page',
    //   },
    // );
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
          
          // onNavigationRequest: (request) {
          //    Get.to(() => 
          //    SpotifyCompainWidget(title: widget.title, url: request.url, logImage: widget.logImage),
          //    preventDuplicates: false,);
          //   return NavigationDecision.prevent;
          // },
          onWebResourceError: (WebResourceError error) {},
          // onNavigationRequest: (NavigationRequest request) {
          //   if (request.url.startsWith('https://www.youtube.com/')) {
          //     return NavigationDecision.prevent;
          //   }
          //   return NavigationDecision.navigate;
          // },
        ),
      )
      ..loadRequest(Uri.parse(widget.compainName));
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

  String compainUrl = 'http://sportblitznews.se/?utm_source=facebook&utm_medium=cpc&utm_campaign=';
  // final fullUrl = compainUrl + widget.compainName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColorSwatch.appBarColor,
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
        color: AppColorSwatch.appBarColor,
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


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: WebView(
//           initialUrl: '',
//           javascriptMode: JavascriptMode.unrestricted,
//         ),
//       ),
//     );
//   }
// }