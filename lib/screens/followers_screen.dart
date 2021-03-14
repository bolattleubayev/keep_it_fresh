import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/users_search_list.dart';
import '../auth/sign_up.dart';

class FollowersScreen extends StatelessWidget {
  final int count;
  final String categoryName;
  final List<dynamic> uids;

  FollowersScreen(
      {@required this.count, @required this.categoryName, this.uids});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: categoryName,
      ),
      body: uids == null
          ? Center(
              child: Text(
              "нет $categoryName",
              style: Theme.of(context).textTheme.headline3,
            ))
          : FutureBuilder(
              future: getFollowData(uids: List<String>.from(uids)),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      UserSearchList(
                        items: snapshot.data,
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
    );
  }
}
