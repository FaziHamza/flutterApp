class ApiPodCastResponse {
  final bool successFlag;
  final int totalCount;
  final List<PodCast> data;
  final dynamic miscData;
  final String message;

  ApiPodCastResponse({
    required this.successFlag,
    required this.totalCount,
    required this.data,
    this.miscData,
    required this.message,
  });

  factory ApiPodCastResponse.fromJson(Map<String, dynamic> json) {
    return ApiPodCastResponse(
      successFlag: json['successFlag'],
      totalCount: json['totalCount'],
      data: List<PodCast>.from(json['data'].map((x) => PodCast.fromJson(x))),
      miscData: json['miscData'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        'successFlag': successFlag,
        'totalCount': totalCount,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
        'miscData': miscData,
        'message': message,
      };
}

class PodCast {
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

  PodCast({
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

  factory PodCast.fromJson(Map<String, dynamic> json) => PodCast(
        id: json['id'],
        regionId: json['regionId'],
        mainHeading: json['mainHeading'],
        topicId: json['topicId'],
        subTopicId: json['subTopicId'],
        videoLink: json['videoLink'],
        thumbnail: json['thumbnail'],
        embededCode: json['embededCode'],
        text: json['text'],
        datetime: json['datetime'] != null ? DateTime.parse(json['datetime']) : null,
        isActive: json['isActive'],
        createdOn: json['createdOn'] != null ? DateTime.parse(json['createdOn']) : null,
        createdBy: json['createdBy'],
        editOn: json['editOn'] != null ? DateTime.parse(json['editOn']) : null,
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
