import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/views/user_views.dart';
import '../views/photo_views.dart';
import '../views/posts_views.dart';

class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "My Social",
          ),
          backgroundColor: Colors.pinkAccent,
          elevation: 0.0,
          bottom: TabBar(
            unselectedLabelColor: Colors.white.withOpacity(0.5),
            labelColor: Colors.pink,
            labelPadding: EdgeInsets.only(left: 5.0, right: 5.0),
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white),
            tabs: [
              Tab(
                child: Icon(Icons.home_outlined),
              ),
              Tab(
                child: Icon(Icons.image_outlined),
              ),
              Tab(
                child: Icon(Icons.account_circle_outlined),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PostsView(),
            PhotoView(),
            UserView(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pinkAccent,
          tooltip: "Add New Post",
          child: Icon(
            Icons.add,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
