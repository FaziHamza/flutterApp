import 'dart:convert';

class ApiHilightsResponse {
  final List<Hilights> news;

  ApiHilightsResponse({
    required this.news,
  });

  factory ApiHilightsResponse.fromJson(Map<String, dynamic> json) {
    return ApiHilightsResponse(
      news: (json['data'] as List).map((e) => Hilights.fromJson(e)).toList(),
    );
  }

  List<Hilights> getNews() {
    return news;
  }
}

class Hilights {
  final String? id;
  final String? regionId;
  final String? mainHeading;
  final String? topicId;
  final String? subTopicId;
  final String? videoLink;
  final String? thumbnail;
  final String? embededCode;
  final String? text;
  final DateTime? datetime;
  final bool? isActive;
  final DateTime? createdOn;
  final String? createdBy;
  final DateTime? editOn;
  final String? editBy;

  Hilights({
    this.id,
    this.regionId,
    this.mainHeading,
    this.topicId,
    this.subTopicId,
    this.videoLink,
    this.thumbnail,
    this.embededCode,
    this.text,
    this.datetime,
    this.isActive,
    this.createdOn,
    this.createdBy,
    this.editOn,
    this.editBy,
  });

  factory Hilights.fromRawJson(String str) => Hilights.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hilights.fromJson(Map<String, dynamic> json) => Hilights(
        id: json['id'],
        regionId: json['regionId'],
        mainHeading: json['mainHeading'],
        topicId: json['topicId'],
        subTopicId: json['subTopicId'],
        videoLink: json['videoLink'],
        thumbnail: json['thumbnail'],
        embededCode: json['embededCode'],
        text: json['text'],
        datetime: json['datetime'] == null ? null : DateTime.parse(json['datetime']),
        isActive: json['isActive'],
        createdOn: json['createdOn'] == null ? null : DateTime.parse(json['createdOn']),
        createdBy: json['createdBy'],
        editOn: json['editOn'] == null ? null : DateTime.parse(json['editOn']),
        editBy: json['editBy'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'regionId': regionId,
        'mainHeading': mainHeading,
        'topicId': topicId,
        'subTopicId': subTopicId,
        'videoLink': videoLink,
        'thumbnail': thumbnail,
        'embededCode': embededCode,
        'text': text,
        'datetime': datetime?.toIso8601String(),
        'isActive': isActive,
        'createdOn': createdOn?.toIso8601String(),
        'createdBy': createdBy,
        'editOn': editOn?.toIso8601String(),
        'editBy': editBy,
      };
}
