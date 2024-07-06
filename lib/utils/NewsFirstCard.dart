import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/models/News.dart';
import 'package:news/pages/next_page.dart';



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
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedImage(imageUrl:imageUrl, mHight: 200),
            const SizedBox(height: 3),
            if(groupName != "null" && groupName != "" && groupName.isNotEmpty) Row(
              children: [
                Chip(
                  label: Text(groupName,style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 243, 243, 243)
                    )),
                    backgroundColor:  const Color.fromRGBO(54, 88, 128, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: BorderSide.none,
                )
              ],
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
             const SizedBox(height: 3),
            if(details != "null")Text(
              details,
              style:  const TextStyle(
                fontSize: 12,
              ),
              maxLines: 2,
            ),
             const SizedBox(height: 3),
            Row(
              children: [
                 Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 4.0),
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
    super.key, 
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             RoundedImage(imageUrl:imageUrl, mHight: 100),
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
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(79, 79, 80, 1),
                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
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
                //  Chip(
                //   label: Text(timeAgo(postTime),style: const TextStyle(
                //         fontSize: 9,
                //         fontWeight: FontWeight.normal,
                //         color: Color.fromARGB(255, 243, 243, 243)
                //     )),
                //     backgroundColor:  const Color.fromRGBO(79, 79, 80, 1),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     side: BorderSide.none,
                //     padding: const EdgeInsets.all(0),
                // ),
                const Spacer(),
                Image.asset(
                  mId.length > 7 ? 'assets/image/sporspot_news.png' : 'assets/image/afpnews.png',
                //  width: 24,
                  height: 22,
                ),
              ],
            ),
          ],
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
  final double mHight;

  const RoundedImage({super.key, required this.imageUrl, required this.mHight});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
      child: Image.network(
        imageUrl,
      //  width: 200, // Optional: set width
        height: mHight, // Optional: set height
        fit: BoxFit.fitWidth, // Optional: adjust the image fit
      ),
    );
  }
}


class NewsList extends StatelessWidget {
  final List<News> mNewsList;

  const NewsList({super.key, required this.mNewsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: (mNewsList.length / 2).ceil() + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          // First row with one item
          final item = mNewsList[0];
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
              mId: item.id.toString()
            ),
          );
        } else {
          // Subsequent rows with two items
          final int itemIndex1 = (index - 1) * 2 + 1;
          final int itemIndex2 = itemIndex1 + 1;
          return Row(
            children: [
              Expanded(
                child: itemIndex1 < mNewsList.length
                    ? GestureDetector(
                        onTap: () {
                          String article = mNewsList[itemIndex1].articleLink.toString();
                          if (article != "null" && article.isNotEmpty) {
                            Get.to(() => NextPage(
                                  title: mNewsList[itemIndex1].title.toString(),
                                  url: mNewsList[itemIndex1].articleLink.toString(),
                                  logImage: mNewsList[itemIndex1].generalistProfile.toString(),
                                ));
                          }
                        },
                        child: NewsOtherCard(
                          imageUrl: mNewsList[itemIndex1].medias![1].href.toString(),
                          title: mNewsList[itemIndex1].title.toString(),
                          details: mNewsList[itemIndex1].content.toString(),
                          groupName: mNewsList[itemIndex1].generalistName.toString(),
                          postTime: mNewsList[itemIndex1].published ?? DateTime.now(),
                          mId:  mNewsList[itemIndex1].id.toString(),
                        ),
                      )
                    : Container(), // Empty container if no more items
              ),
              Expanded(
                child: itemIndex2 < mNewsList.length
                    ? GestureDetector(
                        onTap: () {
                          String article = mNewsList[itemIndex2].articleLink.toString();
                          if (article != "null" && article.isNotEmpty) {
                            Get.to(() => NextPage(
                                  title: mNewsList[itemIndex2].title.toString(),
                                  url: mNewsList[itemIndex2].articleLink.toString(),
                                  logImage: mNewsList[itemIndex2].generalistProfile.toString(),
                                ));
                          }
                        },
                        child: NewsOtherCard(
                          imageUrl: mNewsList[itemIndex2].medias![1].href.toString(),
                          title: mNewsList[itemIndex2].title.toString(),
                          details: mNewsList[itemIndex2].content.toString(),
                          groupName: mNewsList[itemIndex2].generalistName.toString(),
                          postTime: mNewsList[itemIndex2].published ?? DateTime.now(),
                          mId:  mNewsList[itemIndex1].id.toString(),
                        ),
                      )
                    : Container(), // Empty container if no more items
              ),
            ],
          );
        }
      },
    );
  }
}