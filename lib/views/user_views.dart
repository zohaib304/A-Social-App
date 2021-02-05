import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

Future<List<UsersDetail>> getUsers() async {
  final url = "https://jsonplaceholder.typicode.com/users";

  final response = await http.get(url);

  if (response.statusCode == 200) {
    // ..OK response
    // then parse the JSON
    final List<UsersDetail> users = postsFromJson(response.body);
    return users;
  } else {
    throw Exception("Failed to load users");
  }
}

class UserView extends StatefulWidget {
  UserView({Key key}) : super(key: key);

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<UsersDetail>>(
      future: getUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Failed to load."));
        } else if (snapshot.hasData) {
          return UserList(users: snapshot.data);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class UserList extends StatelessWidget {
  final List<UsersDetail> users;
  const UserList({Key key, this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        UsersDetail p = users[index];
        return Card(
          child: ListTile(
            leading: Container(
              height: double.infinity,
              child: Icon(
                Icons.account_circle_outlined,
                color: Colors.pinkAccent,
                size: 35.0,
              ),
            ),
            title: Text(
              p.username,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
            subtitle: Text(p.email),
          ),
        );
      },
    );
  }
}
