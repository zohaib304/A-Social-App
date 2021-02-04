import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/photo_model.dart';

Future<List<PhotosModel>> getPhotos() async {
  final url = "https://jsonplaceholder.typicode.com/photos";

  final response = await http.get(url);

  if (response.statusCode == 200) {
    // ..OK response
    // then parse the JSON
    final List<PhotosModel> posts = postsFromJson(response.body);
    return posts;
  } else {
    throw Exception("Failed to load posts");
  }
}

class PhotoView extends StatefulWidget {
  PhotoView({Key key}) : super(key: key);

  @override
  _PhotoViewState createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<PhotosModel>>(
      future: getPhotos(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Failed to load."));
        } else if (snapshot.hasData) {
          return PhotoList(photos: snapshot.data);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PhotoList extends StatelessWidget {
  final List<PhotosModel> photos;

  PhotoList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return Image.network(photos[index].thumbnailUrl);
        });
  }
}
