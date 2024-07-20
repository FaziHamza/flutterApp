import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/models/News.dart';
import 'package:news/models/my_pod_cast_response.dart';
import 'package:news/models/my_sites_reponse.dart';
import 'package:news/models/my_video_hiegh_response.dart';
import 'package:news/pages/next_page.dart';
import 'package:news/pages/potcast_page.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:news/controllers/app_controller.dart';


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
            RoundedImage(imageUrl:imageUrl, mHeight: 200),
            const SizedBox(height: 5),
            Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: const Color(0xff365880),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      groupName != "null" && groupName != "" && groupName.isNotEmpty ? groupName : "Nyheter",
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
            if(details != "null") Html(
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
            if(details != "null") const SizedBox(height: 5),
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
                if(isExternal && endIcon.isNotEmpty) Image.network(
                    endIcon,
                    height: 22,
                    width: 38,
                  ),
                   if(!isExternal || endIcon.isEmail) Image.asset(
                    mId.length > 7 ? 'assets/image/sporspot_news.png' : 'assets/image/afpnews.png',
                    height: 22,
                    width: 38,
                  ),
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
    return Container(
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
              RoundedSmallImage(imageUrl: imageUrl, mHeight: 100, mColor: Colors.transparent),
              const SizedBox(height: 3),
              SizedBox(
               height: 40,
               child:  Text(
                title,style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 3,
              ) 
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
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
                  if(isExternal && endIcon.isNotEmpty) Image.network(
                    endIcon,
                    height: 22,
                    width: 38,
                  ),
                   if(!isExternal || endIcon.isEmail) Image.asset(
                    mId.length > 7 ? 'assets/image/sporspot_news.png' : 'assets/image/afpnews.png',
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

  const NewsHighCard({
    required this.imageUrl,
    required this.groupName,
    required this.title,
    required this.details,
    required this.postTime,
    required this.mId,
    super.key, // Ensure key is properly typed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125, // Adjust the width as per your design requirements
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.only(left: 0, top: 0, bottom: 5),
         color: const Color(0xff262626),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Stack(
                alignment: Alignment.center,
                children: [
                RoundedSmallImage(imageUrl: imageUrl, mHeight: 100, mColor: Colors.transparent),
                Positioned(
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
               child:  Text(
                title,style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 3,
              ) 
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
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
                  Image.asset(
                    mId.length > 7 ? 'assets/image/sporspot_news.png' : 'assets/image/afpnews.png',
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

  const WebViewDialog({super.key, required this.embededCode});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.all(10),
      content: SizedBox(
        width: double.maxFinite,
        height: 500,
        child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Row(
                        children: [
                          GestureDetector(
                           onTap: () {
                              Navigator.of(context).pop();
                             },
                          child: const Icon(
                                Icons.close, color: Color(0xFF666666),
                              ),
                          )   
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                        width: double.maxFinite,
                          height: 400,
                          child: WebViewWidget(
                            controller: WebViewController()
                              ..setJavaScriptMode(JavaScriptMode.unrestricted)
                              ..loadHtmlString(embededCode),
                          ),
                        ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 3),
                        child: AppController.to.copyRight(),
                      ),
                      Image.asset(
                        'assets/image/black_sport_news.png',
                        width: 120,
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
      )

    );
  }
}

void showWebViewDialog(BuildContext context, String url) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return WebViewDialog(embededCode: url);
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
      width: 65, // Adjust the width as per your design requirements
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.only(left: 0, top: 0, bottom: 5),
         color: const Color(0xff262626),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedSmallImage(imageUrl: imageUrl, mHeight: 65,mColor:Colors.white)
            ],
          ),
        ),
      ),
    );
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
    Key? key,
    required this.imageUrl,
    required this.mHeight,
  }) : super(key: key);

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
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
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
        borderRadius: BorderRadius.circular(8.0),
        color: mColor 
      ),
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

// Main NewsList Widget
class NewsList extends StatelessWidget {
  final List<News> mNewsList;
  final List<Hilights> mHilightsList;
  final List<MySite> mMySiteList;
  final List<PodCast> mPodCastList;
  final List<String> todayHighLights;
  final String mHeader;

  const NewsList({
    super.key,
    required this.mNewsList,
    required this.mHilightsList,
    required this.mMySiteList,
    required this.mPodCastList,
    required this.todayHighLights,
    required this.mHeader
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: _calculateItemCount(),
      itemBuilder: (context, index) {
        if (index == 0) {
          // First row with one item
          return _buildFirstRow();
        } else if (index == 1) {
          // Second row (Recent)
          if(mNewsList.length>1){
            return _buildSecondRow();
          } else if(mHilightsList.isNotEmpty){
            return _buildHighlightsRow(context);
          }else if(mMySiteList.isNotEmpty){
            return _buildMySiteListRow();
          }else if(mPodCastList.isNotEmpty){
            return _buildPodCastListRow();
          }else{
            return _buildTodayListRow();
          }
        
        } else if (index == 2) {
          // Highlights row after Recent row
         if(mHilightsList.isNotEmpty && mNewsList.length>1){
            return _buildHighlightsRow(context);
          }else if(mMySiteList.isNotEmpty){
            return _buildMySiteListRow();
          }else if(mPodCastList.isNotEmpty){
            return _buildPodCastListRow();
          } else{
            return _buildTodayListRow();
          }
        } else if (index == 3) {
          // MySiteList row
         if(mMySiteList.isNotEmpty && mHilightsList.isNotEmpty && mNewsList.length > 1){
            return _buildMySiteListRow();
          }else if(mPodCastList.isNotEmpty && mHilightsList.isNotEmpty && mNewsList.length > 1){
            return _buildPodCastListRow();
          } else{
            return _buildTodayListRow();
          }
        }  else if (index == 4) {
          // PodCastList row
          if(mPodCastList.isNotEmpty && mMySiteList.isNotEmpty && mHilightsList.isNotEmpty && mNewsList.length > 1){
            return _buildPodCastListRow();
          }else {
            return _buildTodayListRow();
         }
        } else if (index == 5){
            return _buildTodayListRow();
        }
      },
    );
  }

  int _calculateItemCount() {
    int itemCount = 1; 
    if (mNewsList.length > 1) {
      itemCount++; 
    }
    if (mHilightsList.isNotEmpty) {
      itemCount++; 
    }
    if (mMySiteList.isNotEmpty) {
      itemCount++; 
    }
    if (mPodCastList.isNotEmpty) {
      itemCount++; 
    }
    if (todayHighLights.isNotEmpty) {
      itemCount++; 
    }
    return itemCount;
  }

  Widget _buildFirstRow() {
    final item = mNewsList.isNotEmpty ? mNewsList[0] : null;
    if (item == null) {
      return const SizedBox(); // Return an empty container or placeholder if list is empty
    }

    return GestureDetector(
      onTap: () {
        String article = item.articleLink.toString();
        if (article != "null" && article.isNotEmpty) {
          Get.to(() => NextPage(
            title: item.title.toString(),
            url: item.articleLink.toString(),
            logImage: item.generalistProfile.toString(),
          ));
        }
      },
      child: NewsFirstCard(
        imageUrl: item.medias![1].href.toString(),
        title: item.title.toString(),
        details: item.content.toString(),
        groupName: item.generalistName.toString(),
        postTime: item.published ?? DateTime.now(),
        mId: item.id.toString(),
        endIcon: item.creatorImg ?? '',
        isExternal: item.isExternal == true,
      ),
    );
  }

  Widget _buildSecondRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          child: Text(
            "Mer nyheter",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
           padding: EdgeInsets.only(left: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              mNewsList.length-1,
              (i) {
                final item = mNewsList[i+1];
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: GestureDetector(
                    onTap: () {
                      String article = (item.isExternal == true)? item.articleLink.toString(): getArticalLink(mHeader, item.id.toString());
                      //String article = item.articleLink.toString();
                      print("article: $article");
                      if (article != "null" && article.isNotEmpty) {
                        Get.to(() => NextPage(
                          title: item.title.toString(),
                          url: article,
                          logImage: item.generalistProfile.toString(),
                          hideBar: item.isExternal == false,
                        ));
                      }
                    },
                    child: NewsOtherCard(
                      imageUrl: item.medias![1].href.toString(),
                      title: item.title.toString(),
                      details: item.content.toString(),
                      groupName: item.generalistName.toString(),
                      postTime: item.published ?? DateTime.now(),
                      mId: item.id.toString(),
                      endIcon: item.creatorImg ?? '',
                      isExternal: item.isExternal == true,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHighlightsRow(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          child: Text(
            "Highlights",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
           padding: const EdgeInsets.only(left: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              mHilightsList.length,
              (i) {
                final item = mHilightsList[i];
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: GestureDetector(
                    onTap: () {
                      showWebViewDialog(context, item.embededCode!);
                    },
                    child: NewsHighCard(
                      imageUrl:'https://sportspotadmin.dev/${item.thumbnail}' ,
                      title: item.text.toString(),
                      details: "null",
                      groupName: "null",
                      postTime: item.createdOn ?? DateTime.now(),
                      mId: item.id.toString(),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMySiteListRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          child: Text(
            "My Sites",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
           padding: const EdgeInsets.only(left: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              mMySiteList.length,
              (i) {
                final item = mMySiteList[i];
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: GestureDetector(
                    onTap: () {
                      String article = item.url.toString();
                      if (article != "null" && article.isNotEmpty) {
                        Get.to(() => NextPage(
                          title: item.description.toString(),
                          url: article,
                          logImage: item.iconImage.toString(),
                        ));
                      }
                    },
                    child: MySiteCard(
                     imageUrl: 'https://sportspotadmin.dev/${item.iconImage}',
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPodCastListRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          child: Text(
            "Podcasts",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              mPodCastList.length,
              (i) {
                final item = mPodCastList[i];
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: GestureDetector(
                    onTap: () {
                      String subTopicId = item.subTopicId.toString();
                      if (subTopicId != "null" && subTopicId.isNotEmpty) {
                        Get.to(() => PodcastPage(subtopicId: subTopicId,title: "Pod Cast"));
                      }
                    },
                    child: MySiteCard(
                     imageUrl: 'https://sportspotadmin.dev/${item.thumbnail}',
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

Widget _buildTodayListRow() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        child: Row(
          children: [
            Text(
          "Today Headlines",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer()
          ],
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(left: 7, top: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            todayHighLights.length,
            (i) {
              final item = todayHighLights[i];
              return Padding(
                padding: const EdgeInsets.all(2),
                child: GestureDetector(
                  onTap: () {
                    // Handle onTap for Podcast list item
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.format_align_left,
                          size: 10.0,
                          color: Color(0xFFFFFFFF),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 10.0,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      // Container(
      //               padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      //               margin: const EdgeInsets.only(bottom: 10.0),
      //               decoration: BoxDecoration(
      //                 color: const Color.fromRGBO(79, 79, 80, 1),
      //                 borderRadius: BorderRadius.circular(20.0),
      //               ),
      //               child: const Text(
      //                 'Load More',
      //                 style: TextStyle(
      //                   color: Color.fromARGB(255, 243, 243, 243),
      //                   fontSize: 9.0,
      //                 ),
      //               ),
      //             )
    ],
  );
}

  String getArticalLink(String item, String name) {
    String link = item;
  
    return 'https://sportblitznews.se/news/$link/$name';
  }


}


