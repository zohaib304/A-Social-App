import 'dart:convert';

List<PhotosModel> postsFromJson(String str) =>
    List<PhotosModel>.from(json.decode(str).map((x) => PhotosModel.fromJson(x)));

class PhotosModel {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  PhotosModel({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  factory PhotosModel.fromJson(Map<String, dynamic> json) => PhotosModel(
        albumId: json['albumId'],
        id: json['id'],
        title: json['title'],
        thumbnailUrl: json['thumbnailUrl'],
      );
}
