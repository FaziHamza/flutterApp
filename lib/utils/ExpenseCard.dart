import 'package:flutter/material.dart';
import 'package:news/models/News.dart';

class NewaCard extends StatelessWidget {
  final News news; // Change type to News

  const NewaCard({required this.news}) : super();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      margin: EdgeInsets.all(16),
      child: Container(
        height: 300,
        width: 350,
        child: Stack(
          children: [
            // Background image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image:  NetworkImage(news.medias![1].href.toString()), // Replace with your image asset
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.generalistName.toString(), // Assuming this is a static text for news
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    news.title.toString(), // Display news title
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Description: ${news.content}', // Display news description or content
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.white70,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        news.published.toString(), // Display time ago from news model
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      Spacer(),
                      Text(
                        news.contentEng.toString(), // Display news source
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
