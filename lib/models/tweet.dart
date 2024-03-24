class Tweet {
  final String id;
  final String text;
  final DateTime createdAt;
  final String authorId;
  final List<String>? tags;
  final String? imageId;

  Tweet({required this.id, required this.text, required this.createdAt, required this.authorId, required this.tags, this.imageId});



  factory Tweet.fromJson(Map<String, dynamic> json) {
    print(json);
    List<String>? tagsList;
    if (json['tags'] is List) {
      tagsList = List<String>.from(json['tags']);
    } else if (json['tags'] != null) {
      tagsList = [json['tags'].toString()];
    }

    return Tweet(
      id: json['id'],
      text: json['text'],
      createdAt: DateTime.parse(json['date_created']),
      authorId: json['user_created'],
      tags: tagsList,
      imageId: json['image'],
    );
  }
}
