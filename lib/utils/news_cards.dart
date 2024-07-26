import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:news/pages/next_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/app_controller.dart';
import 'CustomColors.dart';

class NewsFirstCard extends StatelessWidget {
  final String imageUrl;
  final String groupName;
  final String title;
  final String details;
  final String mId;
  final DateTime postTime;
  final bool isExternal;
  final String endIcon;

  const NewsFirstCard({
    required this.imageUrl,
    required this.groupName,
    required this.title,
    required this.details,
    required this.postTime,
    required this.mId,
    this.isExternal = false,
    this.endIcon = '',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(5),
      color: const Color(0xff262626),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedImage(imageUrl: imageUrl, mHeight: 200),
            const SizedBox(height: 5),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: const Color(0xff365880),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                groupName != "null" && groupName != "" && groupName.isNotEmpty
                    ? groupName
                    : "Nyheter",
                style: const TextStyle(
                  color: Color.fromARGB(255, 243, 243, 243),
                  fontSize: 12.0,
                ),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
            ),
            //const SizedBox(height: 1),
            if (details != "null")
              Html(
                data: "<p>$details</p>",
                style: {
                  "p": Style(
                    fontSize: FontSize(12.0),
                    color: Colors.white,
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                    maxLines: 3,
                  ),
                  "iframe": Style(
                    width: Width(315.0),
                    height: Height(315.0),
                  ),
                },
              ),
            if (details != "null") const SizedBox(height: 5),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(79, 79, 80, 1),
                    borderRadius: BorderRadius.circular(
                        20.0), // Adjust the radius as needed
                    //border: Border.all(color: Colors.white, width: 1.0)
                  ),
                  child: Text(
                    timeAgo(postTime),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 243, 243, 243),
                      fontSize: 9.0, // Adjust the font size as needed
                    ),
                  ),
                ),
                const Spacer(),
                if (isExternal &&
                    endIcon.isNotEmpty &&
                    !AppController.to.isSvg(endIcon))
                  Image.network(
                    endIcon,
                    height: 22,
                    width: 38
                  ),
                if (isExternal &&
                    endIcon.isNotEmpty &&
                    AppController.to.isSvg(endIcon))
                  SvgPicture.network(
                    endIcon,
                    height: 22,
                    fit: BoxFit.contain
                  ),
                if (!isExternal || endIcon.isEmail)
                  Image.asset(
                    mId.length > 7
                        ? 'assets/image/sporspot_news.png'
                        : 'assets/image/afpnews.png',
                    height: 22,
                    width: 38,
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NewsOtherCard extends StatelessWidget {
  final String imageUrl;
  final String groupName;
  final String title;
  final String details;
  final String mId;
  final DateTime postTime;
  final bool isExternal;
  final String endIcon;

  const NewsOtherCard({
    required this.imageUrl,
    required this.groupName,
    required this.title,
    required this.details,
    required this.postTime,
    required this.mId,
    this.isExternal = false,
    this.endIcon = '',
    super.key, // Ensure key is properly typed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 125, // Adjust the width as per your design requirements
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.only(left: 0, top: 0, bottom: 5),
        color: const Color(0xff262626),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedSmallImage(
                  imageUrl: imageUrl, mHeight: 100, mColor: Colors.transparent),
              const SizedBox(height: 3),
              SizedBox(
                  height: 40,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 3,
                  )),
              const SizedBox(height: 3),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(79, 79, 80, 1),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      timeAgo(postTime),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 243, 243, 243),
                        fontSize: 9.0,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (isExternal &&
                      endIcon.isNotEmpty &&
                      !AppController.to.isSvg(endIcon))
                    Image.network(
                        endIcon,
                        height: 22,
                        width: 38
                    ),
                  if (isExternal &&
                      endIcon.isNotEmpty &&
                      AppController.to.isSvg(endIcon))
                    SvgPicture.network(
                        endIcon,
                        height: 22,
                        fit: BoxFit.contain
                    ),
                  if (!isExternal || endIcon.isEmail)
                    Image.asset(
                      mId.length > 7
                          ? 'assets/image/sporspot_news.png'
                          : 'assets/image/afpnews.png',
                      height: 22,
                      width: 38,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewsHighCard extends StatelessWidget {
  final String imageUrl;
  final String groupName;
  final String title;
  final String details;
  final String mId;
  final DateTime postTime;
  final bool isExternal;
  final String endIcon;
  final String matchUrl;

  const NewsHighCard({
    required this.imageUrl,
    required this.groupName,
    required this.title,
    required this.details,
    required this.postTime,
    required this.mId,
    this.isExternal = false,
    this.endIcon = '',
    this.matchUrl = '',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 125,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.only(left: 0, top: 0, bottom: 5),
        color: const Color(0xff262626),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(alignment: Alignment.center, children: [
                RoundedSmallImage(
                    imageUrl: imageUrl,
                    mHeight: 100,
                    mColor: Colors.transparent),
                const Positioned(
                  child: Icon(
                    Icons.play_circle_filled,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ]),
              const SizedBox(height: 3),
              SizedBox(
                  height: 40,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 3,
                  )),
              if (matchUrl != "null" && matchUrl.isNotEmpty)
                Center(
                  child: InkWell(
                    onTap: () {
                      if (matchUrl != "null" && matchUrl.isNotEmpty) {
                        Get.to(() => NextPage(
                              title: title,
                              url: matchUrl,
                              logImage: imageUrl,
                            ));
                      }
                    },
                    child: const Text(
                      'View Match',
                      style: TextStyle(
                        color: Colors.white,
                        // Change text color to indicate it is clickable
                        decoration:
                            TextDecoration.underline, // Underline the text
                      ),
                    ),
                  ),
                ),
              if (matchUrl != "null" && matchUrl.isNotEmpty)
                const SizedBox(height: 5),
              const SizedBox(height: 3),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(79, 79, 80, 1),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      timeAgo(postTime),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 243, 243, 243),
                        fontSize: 9.0,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (isExternal && endIcon.isNotEmpty)
                    Image.network(
                      endIcon,
                      height: 22,
                      width: 38,
                    ),
                  if (mId.isNotEmpty && (!isExternal || endIcon.isEmail))
                    Image.asset(
                      mId.length > 7
                          ? 'assets/image/sporspot_news.png'
                          : 'assets/image/afpnews.png',
                      height: 22,
                      width: 38,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WebViewDialog extends StatelessWidget {
  final String embededCode;
  final bool isSingle;

  const WebViewDialog(
      {super.key, required this.embededCode, required this.isSingle});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.all(30),
        content: SizedBox(
          width: double.maxFinite,
          height: 220,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  height: 220,
                  child: WebViewWidget(
                    controller: WebViewController()
                      ..setJavaScriptMode(JavaScriptMode.unrestricted)
                      ..loadRequest(Uri.parse(
                          '${isSingle ? extractIframeSrc2(embededCode) : extractIframeSrc(embededCode)}&autoplay=1')),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

String extractIframeSrc(String html) {
  String searchString = 'src="';
  int startIndex = html.indexOf(searchString);
  if (startIndex == -1) {
    return 'src attribute not found';
  }
  startIndex += searchString.length;
  int endIndex = html.indexOf('"', startIndex);
  if (endIndex == -1) {
    return 'End quote not found';
  }
  String extractedSrc = html.substring(startIndex, endIndex);
  return extractedSrc;
}

String extractIframeSrc2(String html) {
  String searchString = 'src=\'';
  int startIndex = html.indexOf(searchString);
  if (startIndex == -1) {
    return 'src attribute not found';
  }
  startIndex += searchString.length;
  int endIndex = html.indexOf('\'', startIndex);
  if (endIndex == -1) {
    return 'End quote not found';
  }
  String extractedSrc = html.substring(startIndex, endIndex);
  return extractedSrc;
}

void showWebViewDialog(BuildContext context, String url, bool isSingle) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      if (kDebugMode) {
        print('Src= ${extractIframeSrc(url)}');
      }
      return WebViewDialog(embededCode: url, isSingle: isSingle);
    },
  );
}

class MySiteCard extends StatelessWidget {
  final String imageUrl;

  const MySiteCard({
    required this.imageUrl,
    super.key, // Ensure key is properly typed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 80, // Adjust the width as per your design requirements
        child: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.only(left: 0, top: 0, bottom: 5),
            color: const Color(0xff262626),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RoundedSmallImage(
                      imageUrl: imageUrl, mHeight: 65, mColor: Colors.white)
                ],
              ),
            ),
          ),
        ));
  }
}

String timeAgo(DateTime publishedDate) {
  DateTime now = DateTime.now();
  Duration difference = now.difference(publishedDate);
  if (difference.inDays >= 1) {
    return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
  } else if (difference.inHours >= 1) {
    return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
  } else if (difference.inMinutes >= 1) {
    return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
  } else {
    return 'Just now';
  }
}

class RoundedImage extends StatelessWidget {
  final String imageUrl;
  final double mHeight;

  const RoundedImage({
    super.key,
    required this.imageUrl,
    required this.mHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0xff262626),
            blurRadius: 0.0,
            offset: Offset(0, 8), // Adjusted offset for shadow position
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              height: mHeight,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      const Color(0xff262626),
                      const Color(0xff262626).withOpacity(0.7),
                      const Color(0xff262626).withOpacity(0.4),
                      const Color(0xff262626).withOpacity(0.1),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
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

class RoundedSmallImage extends StatelessWidget {
  final String imageUrl;
  final double mHeight;
  final Color mColor;

  const RoundedSmallImage({
    super.key,
    required this.imageUrl,
    required this.mHeight,
    required this.mColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), color: mColor),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              height: mHeight,
              fit: BoxFit.cover,
              width: double.infinity,
              // color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
