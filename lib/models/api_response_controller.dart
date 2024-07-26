import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:news/models/api_highlights_response.dart';
import 'package:news/models/News.dart';
import 'package:news/models/api_response.dart';
import 'package:news/models/api_today_hilights_response.dart';
import 'package:news/models/my_pod_cast_response.dart';
import 'package:news/models/my_sites_reponse.dart';
import 'package:news/models/my_video_hiegh_response.dart';

import 'package:dio/dio.dart';

class ApiResponseController extends GetxController {
  Dio _dio = Dio();
  final List<CancelToken> _cancelTokens = [];

  Future<ApiResponse> fetchTopics() async {
    var response = await http.get(Uri.parse(
        'https://sportspotadmin.dev//api/Topic/GetTopicWithSubTopicv1?regionId=fc72efe0-7ba9-49bf-95a5-08dbd95a31db'));
    ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
    return apiResponse;
  }

  Future<ApiNewsResponse> fetchNews({
    required String keyword,
    required String lang,
    required String sport,
  }) async {
    var cancelToken = CancelToken();
    _cancelTokens.add(cancelToken);

    var response = await _dio.get(
      'https://sportblitznews.se/V4/api/news/getNewsByTeam',
      queryParameters: {'keyword': keyword, 'lang': lang, 'sport': sport},
      cancelToken: cancelToken,
    );
    if (response.statusCode == 200) {
      ApiNewsResponse apiResponse = ApiNewsResponse.fromJson(response.data);
      return apiResponse;
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<ApiMySiteResponse> fetchMySites({required String subtopicId}) async {
    var cancelToken = CancelToken();
    _cancelTokens.add(cancelToken);

    var response = await _dio.get(
      'https://sportspotadmin.dev/api/ExternalLink/GetExternalLinkBySubtopicId',
      queryParameters: {'subtopicId': subtopicId},
      cancelToken: cancelToken,
    );
    if (response.statusCode == 200) {
      ApiMySiteResponse apiResponse = ApiMySiteResponse.fromJson(response.data);
      return apiResponse;
    } else {
      throw Exception('Failed to load sites');
    }
  }

  Future<ApiPodCastResponse> fetchMyPodCast(
      {required String subtopicId}) async {
    var cancelToken = CancelToken();
    _cancelTokens.add(cancelToken);

    var response = await _dio.get(
      'https://sportspotadmin.dev/api/VideoPodcast/GetVideoPodcastBySubtopicIdonly',
      queryParameters: {'subtopicId': subtopicId},
      cancelToken: cancelToken,
    );
    if (response.statusCode == 200) {
      ApiPodCastResponse apiResponse =
          ApiPodCastResponse.fromJson(response.data);
      return apiResponse;
    } else {
      throw Exception('Failed to load podcast');
    }
  }

  Future<ApiHilightsResponse> fetchMyHilights(
      {required String subtopicId}) async {
    var cancelToken = CancelToken();
    _cancelTokens.add(cancelToken);

    var response = await _dio.get(
      'https://sportspotadmin.dev/api/VideoHighlight/GetVideoHighlightBySubtopicIdonly',
      queryParameters: {'subtopicId': subtopicId},
      cancelToken: cancelToken,
    );
    if (response.statusCode == 200) {
      ApiHilightsResponse apiResponse =
          ApiHilightsResponse.fromJson(response.data);
      return apiResponse;
    } else {
      throw Exception('Failed to load video Hilights');
    }
  }

  Future<ApiHighlightsResponse> fetchHilights(
      {required String type, required String subtopic}) async {
    var cancelToken = CancelToken();
    _cancelTokens.add(cancelToken);

    if (type == 'compitition') {
      type = 'competition';
    }

    var response = await _dio.get(
      'https://www.scorebat.com/video-api/v3/$type/$subtopic',
      queryParameters: {
        'token':
            'ODE3NDNfMTY5MjUxODgyM18yNDEwMTkwOTQzNGM3NDIxY2MwZjZkNjM3NzNjMGY4NjFmZmNjZTYy'
      },
      cancelToken: cancelToken,
    );
    if (response.statusCode == 200) {
      ApiHighlightsResponse apiResponse =
          ApiHighlightsResponse.fromJson(response.data);
      return apiResponse;
    } else {
      throw Exception('Failed to load Hilights');
    }
  }

  Future<ApiTodayHilightsResponse> fetchTodayHigh({
    required String keyword,
    required String lang,
    required String sport,
  }) async {
    var cancelToken = CancelToken();
    _cancelTokens.add(cancelToken);

    var response = await _dio.get(
      'https://sportblitznews.se/V4/api/news/getNewsByTeamOnly',
      queryParameters: {
        'keyword': keyword,
        'lang': lang,
        'sport': sport,
        'limit': '5'
      },
      cancelToken: cancelToken,
    );
    if (response.statusCode == 200) {
      ApiTodayHilightsResponse apiResponse =
          ApiTodayHilightsResponse.fromJson(response.data);
      return apiResponse;
    } else {
      throw Exception('Failed to load news');
    }
  }

  void cancelAllRequests() {
    try {
      for (var token in _cancelTokens) {
        token.cancel("User navigated to another menu");
      }
      _cancelTokens.clear();
    } on Exception {
      //
    }
  }
}
