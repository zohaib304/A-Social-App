import 'dart:convert';

List<PostsModel> postsFromJson(String str) =>
    List<PostsModel>.from(json.decode(str).map((x) => PostsModel.fromJson(x)));

class PostsModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostsModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body'],
      );
}
