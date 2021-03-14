import 'package:flutter/material.dart';
import 'package:keep_it_fresh/auth/sign_up.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/app_bar_title.dart';
import '../widgets/user_items_grid.dart';
import '../models/item.dart';
import '../widgets/profile_header.dart';

class DiscoverProfileScreen extends StatelessWidget {
  final uid;
  final username;
  DiscoverProfileScreen({
    @required this.uid,
    @required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: username,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileHeader(
            isCurrentUser: false,
            providedUID: uid,
          ),
          FutureBuilder(
            future: isAlreadyFollowing(uid),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final bool isFollowing = snapshot.data;
                final bool isThisUser = isCurrentUser(uid);
                if (isThisUser) {
                  return SizedBox();
                } else {
                  return SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              isFollowing ? "Отписаться" : "Подписаться",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                    color:
                                        const Color.fromRGBO(174, 142, 255, 1),
                                  ),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (isFollowing) {
                            unfollowUser(uid);
                            Navigator.of(context).pop();
                          } else {
                            followUser(uid);
                          }
                        },
                      ),
                    ),
                  );
                }
              }
            },
          ),
          FutureBuilder(
            future: retrieveUserItems(isCurrentUser: false, providedUID: uid),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                List<Map<String, dynamic>> firData =
                    List<Map<String, dynamic>>.from(snapshot.data);

                return UserItemsGrid(
                  items: firData,
                  isCurrentUserItems: false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
