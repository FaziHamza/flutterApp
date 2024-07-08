import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/models/News.dart';
import 'package:news/pages/next_page.dart';
import 'package:flutter_html/flutter_html.dart';


class NewsFirstCard extends StatelessWidget {
  final String imageUrl;
  final String groupName;
  final String title;
  final String details;
  final String mId;
  final DateTime postTime;

  const NewsFirstCard({
    required this.imageUrl,
    required this.groupName,
    required this.title,
    required this.details,
    required this.postTime,
    required this.mId,
    super.key, 
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(5),
      color: const Color(0xff262626),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedImage(imageUrl:imageUrl, mHeight: 200),
         //   const SizedBox(height: 3),
            if(groupName != "null" && groupName != "" && groupName.isNotEmpty) Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: const Color(0xff365880),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      groupName,
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
            if(details != "null") const SizedBox(height: 3),
            Row(
              children: [
                 Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(79, 79, 80, 1),
                    borderRadius: BorderRadius.circular(
                        20.0), // Adjust the radius as needed
                    //border: Border.all(color: Colors.white, width: 1.0)
                  ),
                  child: Text(
                    timeAgo(postTime),
                    style: TextStyle(
                      color: Color.fromARGB(255, 243, 243, 243),
                      fontSize: 9.0, // Adjust the font size as needed
                    ),
                  ),
                ),
                const Spacer(),
                Image.asset(
                  mId.length > 7 ? 'assets/image/sporspot_news.png' : 'assets/image/afpnews.png',
                //  width: 24,
                  height: 24,
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

  const NewsOtherCard({
    required this.imageUrl,
    required this.groupName,
    required this.title,
    required this.details,
    required this.postTime,
    required this.mId,
    Key? key, // Ensure key is properly typed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160, // Adjust the width as per your design requirements
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.only(left: 5, top: 0, bottom: 5),
         color: const Color(0xff262626),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedImage(imageUrl: imageUrl, mHeight: 100),
             // const SizedBox(height: 3),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 3,
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
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
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
                      Color(0xff262626).withOpacity(1), // Adjust opacity as needed
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


// class NewsList extends StatelessWidget {
//   final List<News> mNewsList;

//   const NewsList({super.key, required this.mNewsList});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(5),
//       itemCount: (mNewsList.length / 2).ceil() + 1,
//       itemBuilder: (context, index) {
//         if (index == 0) {
//           // First row with one item
//           final item = mNewsList[0];
//           return GestureDetector(
//             onTap: () {
//               String article = item.articleLink.toString();
//               if (article != "null" && article.isNotEmpty) {
//                 Get.to(() => NextPage(
//                       title: item.title.toString(),
//                       url: item.articleLink.toString(),
//                       logImage: item.generalistProfile.toString(),
//                     ));
//               }
//             },
//             child: NewsFirstCard(
//               imageUrl: item.medias![1].href.toString(),
//               title: item.title.toString(),
//               details: item.content.toString(),
//               groupName: item.generalistName.toString(),
//               postTime: item.published ?? DateTime.now(),
//               mId: item.id.toString()
//             ),
//           );
//         } else {
//           // Subsequent rows with two items
//           final int itemIndex1 = (index - 1) * 2 + 1;
//           final int itemIndex2 = itemIndex1 + 1;
//           return Row(
//             children: [
//               Expanded(
//                 child: itemIndex1 < mNewsList.length
//                     ? GestureDetector(
//                         onTap: () {
//                           String article = mNewsList[itemIndex1].articleLink.toString();
//                           if (article != "null" && article.isNotEmpty) {
//                             Get.to(() => NextPage(
//                                   title: mNewsList[itemIndex1].title.toString(),
//                                   url: mNewsList[itemIndex1].articleLink.toString(),
//                                   logImage: mNewsList[itemIndex1].generalistProfile.toString(),
//                                 ));
//                           }
//                         },
//                         child: NewsOtherCard(
//                           imageUrl: mNewsList[itemIndex1].medias![1].href.toString(),
//                           title: mNewsList[itemIndex1].title.toString(),
//                           details: mNewsList[itemIndex1].content.toString(),
//                           groupName: mNewsList[itemIndex1].generalistName.toString(),
//                           postTime: mNewsList[itemIndex1].published ?? DateTime.now(),
//                           mId:  mNewsList[itemIndex1].id.toString(),
//                         ),
//                       )
//                     : Container(), // Empty container if no more items
//               ),
//               Expanded(
//                 child: itemIndex2 < mNewsList.length
//                     ? GestureDetector(
//                         onTap: () {
//                           String article = mNewsList[itemIndex2].articleLink.toString();
//                           if (article != "null" && article.isNotEmpty) {
//                             Get.to(() => NextPage(
//                                   title: mNewsList[itemIndex2].title.toString(),
//                                   url: mNewsList[itemIndex2].articleLink.toString(),
//                                   logImage: mNewsList[itemIndex2].generalistProfile.toString(),
//                                 ));
//                           }
//                         },
//                         child: NewsOtherCard(
//                           imageUrl: mNewsList[itemIndex2].medias![1].href.toString(),
//                           title: mNewsList[itemIndex2].title.toString(),
//                           details: mNewsList[itemIndex2].content.toString(),
//                           groupName: mNewsList[itemIndex2].generalistName.toString(),
//                           postTime: mNewsList[itemIndex2].published ?? DateTime.now(),
//                           mId:  mNewsList[itemIndex1].id.toString(),
//                         ),
//                       )
//                     : Container(), // Empty container if no more items
//               ),
//             ],
//           );
//         }
//       },
//     );
//   }
// }
class NewsList extends StatelessWidget {
  final List<News> mNewsList;

  const NewsList({Key? key, required this.mNewsList}) : super(key: key);

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
          // Second row (Recent) with next 4 items in horizontal scroll
          return _buildSecondRow("Recent");
        } else {
          // Subsequent rows (Highlights) with remaining items in horizontal scroll
          return _buildSubsequentRow(index, "Highlights");
        }
      },
    );
  }

  int _calculateItemCount() {
    if (mNewsList.length == 1) {
      return 1;
    } else if (mNewsList.length > 1 && mNewsList.length < 6) {
      return 2;
    } else {
      return 3;
    }
  }

  Widget _buildFirstRow() {
    final item = mNewsList.isNotEmpty ? mNewsList[0] : null;
    if (item == null) {
      return SizedBox(); // Return an empty container or placeholder if list is empty
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
      ),
    );
  }

  Widget _buildSecondRow(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              min(4, mNewsList.length - 1),
              (i) {
                final item = mNewsList[i + 1];
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
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
                    child: NewsOtherCard(
                      imageUrl: item.medias![1].href.toString(),
                      title: item.title.toString(),
                      details: item.content.toString(),
                      groupName: item.generalistName.toString(),
                      postTime: item.published ?? DateTime.now(),
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

  Widget _buildSubsequentRow(int index, String title) {
    final startIndex = (index - 1) * 5 + 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              min(5, mNewsList.length - startIndex),
              (i) {
                final item = mNewsList[startIndex + i];
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
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
                    child: NewsOtherCard(
                      imageUrl: item.medias![1].href.toString(),
                      title: item.title.toString(),
                      details: item.content.toString(),
                      groupName: item.generalistName.toString(),
                      postTime: item.published ?? DateTime.now(),
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
}
