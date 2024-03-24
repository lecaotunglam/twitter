// Dans tweet_details.dart

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/Tweet.dart';

class TweetDetails extends StatelessWidget {
  final Tweet tweet;

  const TweetDetails({super.key, required this.tweet});

  Future<Uint8List> getImageFile(String imageId) async {
    final dio = Dio();
    final response = await dio.get(
      'https://twitterlike.shrp.dev/assets/$imageId',
      options: Options(responseType: ResponseType.bytes),
    );

    if (response.statusCode == 200 || response.statusCode == 304) {
      final Uint8List fileBytes = response.data;
      return fileBytes;
    } else {
      throw Exception('Failed to load image file');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${tweet.authorId} - ${tweet.createdAt}'),
          if (tweet.imageId != null) // Use if condition to check if imageId is available
            FutureBuilder<Uint8List>(
              future: getImageFile(tweet.imageId!),
              builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Image.memory(
                    snapshot.data!,
                    width: 50,
                    height: 50,
                  );
                } else {
                  return const Text('No image data available');
                }
              },
            ),
          const SizedBox(height: 16.0),
          const Text('Tags:'),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            children: (tweet.tags ?? []).map((tag) => Chip(label: Text(tag))).toList(),
          ),
        ],
      ),
    );
  }


}



