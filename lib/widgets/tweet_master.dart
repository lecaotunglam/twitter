import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/Tweet.dart';
import '../widgets/tweet_details.dart';

class TweetMaster extends StatefulWidget {
  const TweetMaster({super.key});

  @override
  State<TweetMaster> createState() => _TweetMasterState();
}

class _TweetMasterState extends State<TweetMaster> {
  late Future<List<Tweet>> _tweetsFuture;

  @override
  void initState() {
    super.initState();
    _tweetsFuture = fetchTweets();
  }

  Future<List<Tweet>> fetchTweets() async {
    try {
      final dio = Dio();
      final response = await dio.get('https://twitterlike.shrp.dev/items/tweets');
            options: Options(responseType: ResponseType.json);
      print(response);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 304) {
        final List<dynamic> jsonTweets = response.data['data'];
        print(jsonTweets); // Print the JSON data received from the API
        final List<Tweet> tweets = jsonTweets.map((json) => Tweet.fromJson(json)).toList();
        print(tweets); // Print the list of tweets before returning

        print('Request URL: ${response.requestOptions.uri}');
        print('Request Headers: ${response.requestOptions.headers}');
        return tweets;
      } else {
        throw Exception('Failed to load tweets');
      }
    } catch (e) {
      print('Error fetching tweets: $e');
      throw Exception('Failed to load tweets: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Tweet>>(
      future: _tweetsFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Tweet>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final List<Tweet> tweets = snapshot.data!;
          return ListView.builder(
            itemCount: tweets.length,
            itemBuilder: (BuildContext context, int index) {
              final Tweet tweet = tweets[index];
              return SizedBox(
                height: 200, // Adjust the height as needed
                child: TweetDetails(tweet: tweet),
              );
            },
          );
        } else {
          return const Center(child: Text('No tweets available'));
        }
      },
    );
  }

}




