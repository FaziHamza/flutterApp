import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:news/models/News.dart';
import 'package:news/models/api_response.dart';
import 'package:news/models/my_pod_cast_response.dart';
import 'package:news/models/my_sites_reponse.dart';
import 'package:news/models/my_video_hiegh_response.dart';

class ApiResponseController extends GetxController {
  Future<ApiResponse> fetchTopics() async {
    var response = await http.get(Uri.parse(
        'https://sportspotadmin.dev//api/Topic/GetTopicWithSubTopicv1?regionId=fc72efe0-7ba9-49bf-95a5-08dbd95a31db'));
    ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
    return apiResponse;
  }



  Future<ApiNewsResponse> fetchNews({
    required String keyword,required String lang,required String sport,
  }) async {
    var uri = Uri.parse('https://sportblitznews.se/V4/api/news/getNewsByTeam?keyword=$keyword&lang=$lang&sport=$sport');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
       print('fetchNews: ${response.body}');
      ApiNewsResponse apiResponse = ApiNewsResponse.fromJson(jsonDecode(response.body));
      return apiResponse;
    } else {
      throw Exception('Failed to load news');
    }
  }


  Future<ApiMySiteResponse> fetchMySites({ required String subtopicId}) async {
    var uri = Uri.parse('https://sportspotadmin.dev/api/ExternalLink/GetExternalLinkBySubtopicId?subtopicId=$subtopicId');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
       print('fetchMySites: ${response.body}');
      ApiMySiteResponse apiResponse = ApiMySiteResponse.fromJson(jsonDecode(response.body));
      return apiResponse;
    } else {
      throw Exception('Failed to load news');
    }
  }

  

  Future<ApiPodCastResponse> fetchMyPodCast({ required String subtopicId}) async {
    var uri = Uri.parse('https://sportspotadmin.dev//api/VideoPodcast/GetVideoPodcastBySubtopicIdonly?subtopicId=$subtopicId');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
       print('fetchMyPodCast: ${response.body}');
      ApiPodCastResponse apiResponse = ApiPodCastResponse.fromJson(jsonDecode(response.body));
      return apiResponse;
    } else {
      throw Exception('Failed to load news');
    }
  }

  

  Future<ApiHilightsResponse> fetchMyHilights({ required String subtopicId}) async {
    var uri = Uri.parse('https://sportspotadmin.dev//api/VideoHighlight/GetVideoHighlightBySubtopicIdonly?subtopicId=$subtopicId');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
       print('fetchMyHilights: ${response.body}');
      ApiHilightsResponse apiResponse = ApiHilightsResponse.fromJson(jsonDecode(response.body));
      return apiResponse;
    } else {
      throw Exception('Failed to load news');
    }
  }


}
