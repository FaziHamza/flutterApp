import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:news/models/api_response.dart';

class ApiResponseController extends GetxController {
  Future<ApiResponse> fetchTopics() async {
    var response = await http.get(Uri.parse(
        'https://sportspotadmin.dev//api/Topic/GetTopicWithSubTopicv1?regionId=fc72efe0-7ba9-49bf-95a5-08dbd95a31db'));
    ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
    return apiResponse;
  }
}
