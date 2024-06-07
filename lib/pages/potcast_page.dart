import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';

class PodcastPage extends StatefulWidget {
  final String subtopicId;
  final String title;
  PodcastPage({required this.subtopicId, required this.title});

  @override
  _PodcastPageState createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
  List<dynamic> videoPodcasts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://sportspotadmin.dev/api/VideoPodcast/GetVideoPodcastBySubtopicIdonly?subtopicId=${widget.subtopicId}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        videoPodcasts = data['data'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 57, 67, 78),
        title: Text('Podcasts'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: videoPodcasts.length,
              itemBuilder: (context, index) {
                final podcast = videoPodcasts[index];
                return Card(
                  margin: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          podcast['text'] ?? 'No Title',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          height: 200,
                          child: WebViewWidget(
                            controller: WebViewController()
                              ..setJavaScriptMode(JavaScriptMode.unrestricted)
                              ..loadHtmlString(podcast['embededCode']),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
