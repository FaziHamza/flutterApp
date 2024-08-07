import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:news/pages/next_page.dart';
import 'package:news/utils/app_color_swatch.dart';
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
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(5),
      color: customColors.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: Alignment.bottomLeft, children: [
              RoundedImage(imageUrl: imageUrl, mHeight: 200),
              Padding(
                padding: const EdgeInsets.only(bottom: 1, left: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: const Color(0xff365880),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    groupName != "null" &&
                            groupName != "" &&
                            groupName.isNotEmpty
                        ? groupName
                        : "Nyheter",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 243, 243, 243),
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: customColors.titleTextColor),
              maxLines: 2,
            ),
            //const SizedBox(height: 1),
            if (details != "null")
              Html(
                data: "<p>$details</p>",
                style: {
                  "p": Style(
                    fontSize: FontSize(14.0),
                    color: customColors.titleTextColor,
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
                    color: customColors.badgeColor,
                    borderRadius: BorderRadius.circular(
                        20.0), // Adjust the radius as needed
                    //border: Border.all(color: Colors.white, width: 1.0)
                  ),
                  child: Text(
                    timeAgo(postTime),
                    style: TextStyle(
                      color: customColors.badgeTextColor,
                      fontSize: 9.0, // Adjust the font size as needed
                    ),
                  ),
                ),
                const Spacer(),
                if (isExternal &&
                    endIcon.isNotEmpty &&
                    !AppController.to.isSvg(endIcon))
                  Image.network(endIcon, height: 22, width: 38),
                if (isExternal &&
                    endIcon.isNotEmpty &&
                    AppController.to.isSvg(endIcon))
                  SvgPicture.network(endIcon, height: 22, fit: BoxFit.contain),
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
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return SizedBox(
      width: 125, // Adjust the width as per your design requirements
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.only(left: 0, top: 0, bottom: 5),
        color: customColors.cardColor,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedSmallImage(
                  imageUrl: imageUrl, mHeight: 100, mColor: Colors.transparent),
              const SizedBox(height: 3),
              SizedBox(
                  height: 65,
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: customColors.titleTextColor),
                    maxLines: 3,
                  )),
              const SizedBox(height: 3),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: customColors.badgeColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      timeAgo(postTime),
                      style: TextStyle(
                        color: customColors.badgeTextColor,
                        fontSize: 9.0,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (isExternal &&
                      endIcon.isNotEmpty &&
                      !AppController.to.isSvg(endIcon))
                    Image.network(endIcon, height: 22, width: 38),
                  if (isExternal &&
                      endIcon.isNotEmpty &&
                      AppController.to.isSvg(endIcon))
                    SvgPicture.network(endIcon,
                        height: 22, fit: BoxFit.contain),
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
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return SizedBox(
      width: 125,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.only(left: 0, top: 0, bottom: 5),
        color: customColors.cardColor,
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
                Container(
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    color: Colors.white, // Background color
                    shape: BoxShape.circle, // Circular shape
                  ), // Padding to give space around the icon
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ]),
              const SizedBox(height: 3),
              SizedBox(
                  height: 65,
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: customColors.titleTextColor),
                    maxLines: 3,
                  )),
              if (matchUrl != "null" && matchUrl.isNotEmpty)
                Center(
                  child: InkWell(
                    onTap: () {
                      if (matchUrl != "null" && matchUrl.isNotEmpty) {
                        Get.to(() => NextPage(
                              title: '',
                              url: matchUrl,
                              logImage: '',
                            ));
                      }
                    },
                    child: Container(
                      width: 75,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 3.0),
                      decoration: BoxDecoration(
                        color: AppColorSwatch.blue,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            size: 10.0,
                            color: Colors.white,
                          ),
                          Spacer(flex: 3),
                          Text(
                            'View Match',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          )
                        ],
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
                      color: customColors.badgeColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      timeAgo(postTime),
                      style: TextStyle(
                        color: customColors.badgeTextColor,
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
  final bool isAuto;
  final double mHeight;
  final double radius;

  const WebViewDialog({
    super.key,
    required this.embededCode,
    required this.isSingle,
    required this.isAuto,
    required this.mHeight,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.all(30),
        content: SizedBox(
          width: double.maxFinite,
          height: mHeight,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              // Adjust the radius as needed
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    height: mHeight,
                    child: WebViewWidget(
                      controller: WebViewController()
                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                        ..loadRequest(Uri.parse(
                            '${isSingle ? extractIframeSrc2(embededCode) : extractIframeSrc(embededCode)}${isAuto ? '&autoplay=1' : ''}')),
                    ),
                  )
                ],
              ),
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

void showWebViewDialog(BuildContext context, String url, bool isSingle,
    bool isAuto, double mHeight, double radius) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      if (kDebugMode) {
        print('Src= ${extractIframeSrc(url)}');
      }
      return WebViewDialog(
        embededCode: url,
        isSingle: isSingle,
        isAuto: isAuto,
        mHeight: mHeight,
        radius: radius,
      );
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
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return SizedBox(
        width: 85, // Adjust the width as per your design requirements
        child: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.only(left: 0, top: 0, bottom: 5),
            color: customColors.cardColor,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RoundedSmallImage(
                      imageUrl: imageUrl,
                      mHeight: 65,
                      mColor: customColors.sitesCardColor ?? Colors.white)
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
