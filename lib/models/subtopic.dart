import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hive/hive.dart';

part 'subtopic.g.dart'; //hive generators

@HiveType(typeId: 0)
class Subtopic extends HiveObject {
  @HiveField(0)
  final String? subTopicId;
  @HiveField(1)
  final String? topicId;
  @HiveField(3)
  final String? regionId;
  @HiveField(4)
  final String? mainHeading;
  @HiveField(5)
  final String? name;
  @HiveField(6)
  final String? subtopicHeadline;
  @HiveField(7)
  final String? keyword;
  @HiveField(8)
  final String? groupkeyword;
  @HiveField(9)
  final String? news;
  @HiveField(10)
  final String? highlightType;
  @HiveField(11)
  final String? highlights;
  @HiveField(12)
  final String? description;
  @HiveField(13)
  final String? logo;
  @HiveField(14)
  final String? newsIcon;
  @HiveField(15)
  final String? videoIcon;
  @HiveField(16)
  final int? position;
  @HiveField(17)
  final int? sequence;
  @HiveField(18)
  final bool? isMobile;
  @HiveField(19)
  final bool? isExternalUrl;
  @HiveField(20)
  final String? externalUrl;

  RxBool isSwitchedOn;

  Subtopic({
    this.subTopicId,
    this.topicId,
    this.regionId,
    this.mainHeading,
    this.name,
    this.subtopicHeadline,
    this.keyword,
    this.groupkeyword,
    this.news,
    this.highlightType,
    this.highlights,
    this.description,
    this.logo,
    this.newsIcon,
    this.videoIcon,
    this.position,
    this.sequence,
    this.isMobile,
    this.isExternalUrl,
    this.externalUrl,
    bool switchedOn = false,
  }) : isSwitchedOn = switchedOn.obs;

  Subtopic copyWith({
    String? subTopicId,
    String? topicId,
    String? regionId,
    String? mainHeading,
    String? name,
    String? subtopicHeadline,
    String? keyword,
    String? groupkeyword,
    String? news,
    String? highlightType,
    String? highlights,
    String? description,
    String? logo,
    String? newsIcon,
    String? videoIcon,
    int? position,
    int? sequence,
    bool? isMobile,
    bool? isExternalUrl,
    String? externalUrl,
  }) =>
      Subtopic(
        subTopicId: subTopicId ?? this.subTopicId,
        topicId: topicId ?? this.topicId,
        regionId: regionId ?? this.regionId,
        mainHeading: mainHeading ?? this.mainHeading,
        name: name ?? this.name,
        subtopicHeadline: subtopicHeadline ?? this.subtopicHeadline,
        keyword: keyword ?? this.keyword,
        groupkeyword: groupkeyword ?? this.groupkeyword,
        news: news ?? this.news,
        highlightType: highlightType ?? this.highlightType,
        highlights: highlights ?? this.highlights,
        description: description ?? this.description,
        logo: logo ?? this.logo,
        newsIcon: newsIcon ?? this.newsIcon,
        videoIcon: videoIcon ?? this.videoIcon,
        position: position ?? this.position,
        sequence: sequence ?? this.sequence,
        isMobile: isMobile ?? this.isMobile,
        isExternalUrl: isExternalUrl ?? this.isExternalUrl,
        externalUrl: externalUrl ?? this.externalUrl,
      );

  factory Subtopic.fromRawJson(String str) =>
      Subtopic.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Subtopic.fromJson(Map<String, dynamic> json) =>
      Subtopic(
        subTopicId: json["subTopicID"],
        topicId: json["topicID"],
        regionId: json["regionId"],
        mainHeading: json["mainHeading"],
        name: json["name"],
        subtopicHeadline: json["subtopicHeadline"],
        keyword: json["keyword"],
        groupkeyword: json["groupkeyword"],
        news: json["news"],
        highlightType: json["highlightType"]!,
        highlights: json["highlights"],
        description: json["description"],
        logo: json["logo"],
        newsIcon: json["newsIcon"],
        videoIcon: json["videoIcon"],
        position: json["position"],
        sequence: json["sequence"],
        isMobile: json["isMobile"],
        isExternalUrl: json["isExternalUrl"],
        externalUrl: json["externalUrl"],
      );

  Map<String, dynamic> toJson() =>
      {
        "subTopicID": subTopicId,
        "topicID": topicId,
        "regionId": regionId,
        "mainHeading": mainHeading,
        "name": name,
        "subtopicHeadline": subtopicHeadline,
        "keyword": keyword,
        "groupkeyword": groupkeyword,
        "news": news,
        "highlightType": highlightType,
        "highlights": highlights,
        "description": description,
        "logo": logo,
        "newsIcon": newsIcon,
        "videoIcon": videoIcon,
        "position": position,
        "sequence": sequence,
        "isMobile": isMobile,
        "isExternalUrl": isExternalUrl,
        "externalUrl": externalUrl,
      };
}
