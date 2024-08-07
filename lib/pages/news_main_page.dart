// Main NewsList Widget
// ignore: must_be_immutable
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/models/News.dart';
import 'package:news/models/api_highlights_response.dart';
import 'package:news/models/api_today_hilights_response.dart';
import 'package:news/models/my_pod_cast_response.dart';
import 'package:news/models/my_sites_reponse.dart';
import 'package:news/models/my_video_hiegh_response.dart';
import 'package:news/pages/next_page.dart';
import 'package:news/utils/CustomColors.dart';
import 'package:news/utils/news_cards.dart';

import '../controllers/app_controller.dart';

@immutable
class MainNewsList extends StatelessWidget {
  final NewListIte mNewListIte;

  MainNewsList({
    super.key,
    required this.mNewListIte,
  });

  List<String> items = [];

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: _calculateItemCount(),
      itemBuilder: (context, index) {
        String mType = items[index];
        if (mType == 'First') {
          return _buildFirstRow();
        }
        if (mType == 'Recent') {
          return _buildSecondRow();
        }
        if (mType == 'VideoH') {
          return _buildHighlightsRow(context);
        }
        if (mType == 'NonVideoH') {
          return _buildNonHighlightsRow(context);
        }
        if (mType == 'Sites') {
          return _buildMySiteListRow();
        }
        if (mType == 'PodCast') {
          return _buildPodCastListRow(context);
        }
        if (mType == 'TodayH') {
          return _buildTodayListRow(customColors);
        }
        return null;
      },
    );
  }

  int _calculateItemCount() {
    items = [];
    if (mNewListIte.mNewsList.isNotEmpty) {
      items.add('First');
    }
    if (mNewListIte.mNewsList.length > 1) {
      items.add('Recent');
    }
    if (mNewListIte.mHilightsList.isNotEmpty) {
      items.add('VideoH');
    }
    if (mNewListIte.mHighlights.isNotEmpty) {
      items.add('NonVideoH');
    }
    if (mNewListIte.mMySiteList.isNotEmpty) {
      items.add('Sites');
    }
    if (mNewListIte.mPodCastList.isNotEmpty) {
      items.add('PodCast');
    }
    if (mNewListIte.todayHighLights.isNotEmpty) {
      items.add('TodayH');
    }
    return items.length;
  }

  Widget _buildFirstRow() {
    final item =
        mNewListIte.mNewsList.isNotEmpty ? mNewListIte.mNewsList[0] : null;
    if (item == null) {
      return const SizedBox(); // Return an empty container or placeholder if list is empty
    }

    return GestureDetector(
      onTap: () {
        String article = (item.isExternal == true)
            ? item.articleLink.toString()
            : item.articleDetailLink.toString();
        if (article != "null" && article.isNotEmpty) {
          Get.to(() =>
              NextPage(title: '', url: article, logImage: '', hideBar: true));
        }
      },
      child: NewsFirstCard(
        imageUrl: item.medias![1].href.toString(),
        title: item.title.toString(),
        details: item.content.toString(),
        groupName: item.generalistName.toString(),
        postTime: item.published ?? DateTime.now(),
        mId: item.id.toString(),
        endIcon: item.iconSource ?? '',
        isExternal: item.isExternal == true,
      ),
    );
  }

  Widget _buildSecondRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 10, left: 10, bottom: 3, top: 10),
          child: Text(
            "Mer nyheter",
            style: TextStyle(
              fontSize: 18,
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
              mNewListIte.mNewsList.length - 1,
              (i) {
                final item = mNewListIte.mNewsList[i + 1];
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: GestureDetector(
                    onTap: () {
                      String article = (item.isExternal == true)
                          ? item.articleLink.toString()
                          : item.articleDetailLink.toString();
                      //String article = item.articleLink.toString();
                      if (kDebugMode) {
                        print("article: $article");
                      }
                      if (article != "null" && article.isNotEmpty) {
                        Get.to(() => NextPage(
                              title: '',
                              url: article,
                              logImage: '',
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
                      endIcon: item.iconSource ?? '',
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
          padding: EdgeInsets.only(right: 10, left: 10, bottom: 5, top: 10),
          child: Text(
            "Highlights",
            style: TextStyle(
              fontSize: 18,
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
              mNewListIte.mHilightsList.length,
              (i) {
                final item = mNewListIte.mHilightsList[i];
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: GestureDetector(
                    onTap: () {
                      showWebViewDialog(
                          context, item.embededCode!, false, true, 220, 0);
                    },
                    child: NewsHighCard(
                      imageUrl: 'https://sportspotadmin.dev/${item.thumbnail}',
                      title: item.text.toString(),
                      details: "null",
                      groupName: "null",
                      postTime: item.createdOn ?? DateTime.now(),
                      mId: item.id.toString(),
                      endIcon: '',
                      isExternal: false,
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

  Widget _buildNonHighlightsRow(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 10, left: 10, bottom: 5, top: 10),
          child: Text(
            "Highlights",
            style: TextStyle(
              fontSize: 18,
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
              mNewListIte.mHighlights.length,
              (i) {
                final item = mNewListIte.mHighlights[i];
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: GestureDetector(
                    onTap: () {
                      showWebViewDialog(
                          context, item.videos.first.embed, true, true, 220, 0);
                    },
                    child: NewsHighCard(
                        imageUrl: item.thumbnail,
                        title: item.title.toString(),
                        details: "null",
                        groupName: "null",
                        postTime: item.date,
                        mId: '',
                        endIcon: '',
                        isExternal: false,
                        matchUrl: item.matchviewUrl),
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
          padding: EdgeInsets.only(right: 10, left: 10, bottom: 5, top: 10),
          child: Text(
            "Mina sajter",
            style: TextStyle(
              fontSize: 18,
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
              mNewListIte.mMySiteList.length,
              (i) {
                final item = mNewListIte.mMySiteList[i];
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: GestureDetector(
                    onTap: () {
                      String article = item.url.toString();
                      if (article != "null" && article.isNotEmpty) {
                        Get.to(() => NextPage(
                              title: '',
                              url: article,
                              logImage: '',
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

  Widget _buildPodCastListRow(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 10, left: 10, bottom: 5, top: 10),
          child: Text(
            "Podcasts",
            style: TextStyle(
              fontSize: 18,
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
              mNewListIte.mPodCastList.length,
              (i) {
                final item = mNewListIte.mPodCastList[i];
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: GestureDetector(
                    onTap: () {
                      // String subTopicId = item.subTopicId.toString();
                      // if (subTopicId != "null" && subTopicId.isNotEmpty) {
                      //   Get.to(() => PodcastPage(
                      //       subtopicId: subTopicId, title: "Pod Cast"));
                      // }
                      showWebViewDialog(context, item.embededCode ?? '', false,
                          false, 150, 20);
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

  Widget _buildTodayListRow(CustomColors customColors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 10, left: 10, bottom: 5, top: 10),
          child: Row(
            children: [
              Text(
                "Dagens rubriker",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer()
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(left: 7, top: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              mNewListIte.todayHighLights.length,
              (i) {
                final item = mNewListIte.todayHighLights[i];
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: GestureDetector(
                    onTap: () {
                      String article = (item.isExternal == true)
                          ? item.articleLink.toString()
                          : item.articleDetailLink.toString();
                      //String article = item.articleLink.toString();
                      if (kDebugMode) {
                        print("article: $article");
                      }
                      if (article != "null" && article.isNotEmpty) {
                        Get.to(() => NextPage(
                              title: '',
                              url: article,
                              logImage: '',
                              hideBar: item.isExternal == false,
                            ));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.format_align_left,
                            size: 12.0,
                            color: customColors.titleTextColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              item.title ??
                                  item.content ??
                                  item.contentEng ??
                                  '',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: customColors.titleTextColor,
                              ),
                              maxLines: 1,
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
    String theme = AppController.to.getIsDark() ? 'dark' : 'light';
    return 'https://article.sportspotadmin.dev/?newsId=$name&lang=sv&theme=$theme';
  }
}

class NewListIte {
  final List<News> mNewsList;
  final List<Hilights> mHilightsList;
  final List<MySite> mMySiteList;
  final List<PodCast> mPodCastList;
  final List<TodayHilights> todayHighLights;
  final List<HighLights> mHighlights;
  final String mHeader;

  NewListIte({
    required this.mNewsList,
    required this.mHilightsList,
    required this.mMySiteList,
    required this.mPodCastList,
    required this.todayHighLights,
    required this.mHighlights,
    required this.mHeader,
  });
}
