import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/models/News.dart';
import 'package:news/models/my_pod_cast_response.dart';
import 'package:news/models/my_sites_reponse.dart';
import 'package:news/models/my_video_hiegh_response.dart';
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
              RoundedSmallImage(imageUrl: imageUrl, mHeight: 100, mColor: Colors.transparent),
              const SizedBox(height: 3),
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


class MySiteCard extends StatelessWidget {
  final String imageUrl;


  const MySiteCard({
    required this.imageUrl,
    Key? key, // Ensure key is properly typed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      Color(0xff262626),
                      Color(0xff262626).withOpacity(0.7),
                      Color(0xff262626).withOpacity(0.4),
                      Color(0xff262626).withOpacity(0.1), 
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
    Key? key,
    required this.imageUrl,
    required this.mHeight,
    required this.mColor, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: mColor 
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
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


// class NewsList extends StatelessWidget {
//   final List<News> mNewsList;

//   const NewsList({Key? key, required this.mNewsList}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(5),
//       itemCount: _calculateItemCount(),
//       itemBuilder: (context, index) {
//         if (index == 0) {
//           // First row with one item
//           return _buildFirstRow();
//         } else if (index == 1) {
//           // Second row (Recent) with next 4 items in horizontal scroll
//           return _buildSecondRow("Recent");
//         } else {
//           // Subsequent rows (Highlights) with remaining items in horizontal scroll
//           return _buildSubsequentRow(index, "Highlights");
//         }
//       },
//     );
//   }

//   int _calculateItemCount() {
//     if (mNewsList.length == 1) {
//       return 1;
//     } else if (mNewsList.length > 1 && mNewsList.length < 6) {
//       return 2;
//     } else {
//       return 3;
//     }
//   }

//   Widget _buildFirstRow() {
//     final item = mNewsList.isNotEmpty ? mNewsList[0] : null;
//     if (item == null) {
//       return SizedBox(); // Return an empty container or placeholder if list is empty
//     }

//     return GestureDetector(
//       onTap: () {
//         String article = item.articleLink.toString();
//         if (article != "null" && article.isNotEmpty) {
//           Get.to(() => NextPage(
//                 title: item.title.toString(),
//                 url: item.articleLink.toString(),
//                 logImage: item.generalistProfile.toString(),
//               ));
//         }
//       },
//       child: NewsFirstCard(
//         imageUrl: item.medias![1].href.toString(),
//         title: item.title.toString(),
//         details: item.content.toString(),
//         groupName: item.generalistName.toString(),
//         postTime: item.published ?? DateTime.now(),
//         mId: item.id.toString(),
//       ),
//     );
//   }

//   Widget _buildSecondRow(String title) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
//           child: Text(
//             title,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//              crossAxisAlignment: CrossAxisAlignment.start,
//             children: List.generate(
//               min(4, mNewsList.length - 1),
//               (i) {
//                 final item = mNewsList[i + 1];
//                 return Padding(
//                   padding: const EdgeInsets.all(2),
//                   child: GestureDetector(
//                     onTap: () {
//                       String article = item.articleLink.toString();
//                       if (article != "null" && article.isNotEmpty) {
//                         Get.to(() => NextPage(
//                               title: item.title.toString(),
//                               url: item.articleLink.toString(),
//                               logImage: item.generalistProfile.toString(),
//                             ));
//                       }
//                     },
//                     child: NewsOtherCard(
//                       imageUrl: item.medias![1].href.toString(),
//                       title: item.title.toString(),
//                       details: item.content.toString(),
//                       groupName: item.generalistName.toString(),
//                       postTime: item.published ?? DateTime.now(),
//                       mId: item.id.toString(),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSubsequentRow(int index, String title) {
//     final startIndex = (index - 1) * 5 + 1;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
//           child: Text(
//             title,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//              crossAxisAlignment: CrossAxisAlignment.start,
//             children: List.generate(
//               min(5, mNewsList.length - startIndex),
//               (i) {
//                 final item = mNewsList[startIndex + i];
//                 return Padding(
//                   padding: const EdgeInsets.all(2),
//                   child: GestureDetector(
//                     onTap: () {
//                       String article = item.articleLink.toString();
//                       if (article != "null" && article.isNotEmpty) {
//                         Get.to(() => NextPage(
//                               title: item.title.toString(),
//                               url: item.articleLink.toString(),
//                               logImage: item.generalistProfile.toString(),
//                             ));
//                       }
//                     },
//                     child: NewsOtherCard(
//                       imageUrl: item.medias![1].href.toString(),
//                       title: item.title.toString(),
//                       details: item.content.toString(),
//                       groupName: item.generalistName.toString(),
//                       postTime: item.published ?? DateTime.now(),
//                       mId: item.id.toString(),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// Main NewsList Widget
class NewsList extends StatelessWidget {
  final List<News> mNewsList;
  final List<Hilights> mHilightsList;
  final List<MySite> mMySiteList;
  final List<PodCast> mPodCastList;
  final List<String> todayHighLights;

  const NewsList({
    Key? key,
    required this.mNewsList,
    required this.mHilightsList,
    required this.mMySiteList,
    required this.mPodCastList,
    required this.todayHighLights
  }) : super(key: key);

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
            return _buildHighlightsRow();
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
            return _buildHighlightsRow();
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

  Widget _buildSecondRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          child: Text(
            "Recent",
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

  Widget _buildHighlightsRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
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
           padding: EdgeInsets.only(left: 5),
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
                      
                    },
                    child: NewsOtherCard(
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
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
           padding: EdgeInsets.only(left: 5),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
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
          padding: EdgeInsets.only(left: 5),
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
                      // Handle onTap for Podcast list item
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
      Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                    margin: const EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(79, 79, 80, 1),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Text(
                      'Load More',
                      style: TextStyle(
                        color: Color.fromARGB(255, 243, 243, 243),
                        fontSize: 9.0,
                      ),
                    ),
                  )
    ],
  );
}


}
