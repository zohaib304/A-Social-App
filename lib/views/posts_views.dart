import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/posts_model.dart';

Future<List<PostsModel>> getPosts() async {
  final url = "https://jsonplaceholder.typicode.com/posts";

  final response = await http.get(url);

  if (response.statusCode == 200) {
    // ..OK response
    // then parse the JSON
    final List<PostsModel> posts = postsFromJson(response.body);
    return posts;
  } else {
    throw Exception("Failed to load posts");
  }
}

class PostsView extends StatefulWidget {
  @override
  _PostsViewState createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView>
    with AutomaticKeepAliveClientMixin<PostsView> {
  List<PostsModel> postsList = [];
  var loading = false;
  @override
  void initState() {
    super.initState();
    getPosts().then((list) {
      setState(() {
        postsList = list;
        loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Center(
        child: loading == true
            ? ListView.builder(
                itemCount: postsList.length,
                itemBuilder: (context, index) {
                  PostsModel p = postsList[index];
                  return Card(
                    child: ListTile(
                      title: Text(
                        p.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                      subtitle: Text(
                        p.body.replaceAll('\n', ' '),
                      ),
                    ),
                  );
                },
              )
            : CircularProgressIndicator(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
