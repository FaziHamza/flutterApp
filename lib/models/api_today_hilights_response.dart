import 'dart:convert';

class ApiTodayHilightsResponse {
  final List<TodayHilights> news;

  ApiTodayHilightsResponse({
    required this.news,
  });

  factory ApiTodayHilightsResponse.fromJson(List<dynamic> json) {
    return ApiTodayHilightsResponse(
      news: json.map((e) => TodayHilights.fromJson(e)).toList(),
    );
  }

  List<TodayHilights> getNews() {
    return news;
  }
}

class TodayHilights {
  final String? id;
  final String? title;
  final String? titleEng;
  final String? abstractEng;
  final String? contributorName;
  final String? contributorRole;
  final String? contentEng;
  final List<TodayMedia>? medias;
  final String? abstract;
  final String? content;
  final bool? isExternal;
  final String? articleLink;
  final String? articleDetailLink;
  final String? imageLink;
  final String? creator;
  final String? creatorImg;
  final String? type;
  final String? iconSource;
  final bool? isPublished;
  final String? generalistName;
  final String? generalistRole;
  final String? generalistProfile;
  final DateTime? published;

  TodayHilights({
    this.id,
    this.title,
    this.titleEng,
    this.abstractEng,
    this.contributorName,
    this.contributorRole,
    this.contentEng,
    this.medias,
    this.abstract,
    this.content,
    this.isExternal,
    this.articleLink,
    this.articleDetailLink,
    this.imageLink,
    this.creator,
    this.creatorImg,
    this.type,
    this.iconSource,
    this.isPublished,
    this.generalistName,
    this.generalistRole,
    this.generalistProfile,
    this.published,
  });

  factory TodayHilights.fromRawJson(String str) =>
      TodayHilights.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TodayHilights.fromJson(Map<String, dynamic> json) => TodayHilights(
        id: json['_id'],
        title: json['_title'],
        titleEng: json['_titleEng'],
        abstractEng: json['_abstractEng'],
        contributorName: json['_contributorName'],
        contributorRole: json['_contributorRole'],
        contentEng: json['_contentEng'],
        medias: json['_medias'] != null
            ? List<TodayMedia>.from(
                json['_medias'].map((x) => TodayMedia.fromJson(x)))
            : null,
        abstract: json['_abstract'],
        content: json['_content'],
        isExternal: json['_isExternal'],
        articleLink: json['_ArticleLink'],
        articleDetailLink: json['_ArticleDetailLink'],
        imageLink: json['_ImageLink'],
        creator: json['_Creator'],
        creatorImg: json['_CreatorImg'],
        type: json['_Type'],
        iconSource: json['_IconSource'],
        isPublished: json['_IsPublished'],
        generalistName: json['_GeneralistName'],
        generalistRole: json['_GeneralistRole'],
        generalistProfile: json['_GeneralistProfile'],
        published: json['_published'] == null
            ? null
            : DateTime.parse(json['_published']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        '_title': title,
        '_titleEng': titleEng,
        '_abstractEng': abstractEng,
        '_contributorName': contributorName,
        '_contributorRole': contributorRole,
        '_contentEng': contentEng,
        '_medias': medias != null
            ? List<dynamic>.from(medias!.map((x) => x.toJson()))
            : null,
        '_abstract': abstract,
        '_content': content,
        '_isExternal': isExternal,
        '_ArticleLink': articleLink,
        '_ArticleDetailLink': articleDetailLink,
        '_ImageLink': imageLink,
        '_Creator': creator,
        '_CreatorImg': creatorImg,
        '_Type': type,
        '_IconSource': iconSource,
        '_IsPublished': isPublished,
        '_GeneralistName': generalistName,
        '_GeneralistRole': generalistRole,
        '_GeneralistProfile': generalistProfile,
        '_published': published?.toIso8601String(),
      };
}

class TodayMedia {
  final String? role;
  final int? sizeInBytes;
  final String? rendition;
  final int? width;
  final String? href;
  final String? type;
  final int? height;

  TodayMedia({
    this.role,
    this.sizeInBytes,
    this.rendition,
    this.width,
    this.href,
    this.type,
    this.height,
  });

  factory TodayMedia.fromJson(Map<String, dynamic> json) => TodayMedia(
        role: json['role'],
        sizeInBytes: json['sizeInBytes'],
        rendition: json['rendition'],
        width: json['width'],
        href: json['href'],
        type: json['type'],
        height: json['height'],
      );

  Map<String, dynamic> toJson() => {
        'role': role,
        'sizeInBytes': sizeInBytes,
        'rendition': rendition,
        'width': width,
        'href': href,
        'type': type,
        'height': height,
      };
}
