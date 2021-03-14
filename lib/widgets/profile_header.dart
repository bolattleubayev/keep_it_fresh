import 'package:flutter/material.dart';
import '../auth/sign_up.dart';
import '../widgets/profile_photo.dart';
import '../screens/followers_screen.dart';

class ProfileHeader extends StatelessWidget {
  final bool isCurrentUser;
  final String providedUID;

  ProfileHeader({@required this.isCurrentUser, this.providedUID});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: retrieveUserData(
        isCurrentUser: isCurrentUser,
        providedUID: providedUID,
      ),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          int followersCount = 0;
          int followingCount = 0;
          String photoURL = snapshot.data["photoURL"] == null
              ? ""
              : snapshot.data["photoURL"];
          String firstName = snapshot.data["firstName"] == null
              ? ""
              : snapshot.data["firstName"];
          String lastName = snapshot.data["lastName"] == null
              ? ""
              : snapshot.data["lastName"];
          String skinType = snapshot.data["skinType"] == null
              ? "unknown"
              : snapshot.data["skinType"];

          if (snapshot.data["following"] != null) {
            followingCount = snapshot.data["following"].length;
          }

          if (snapshot.data["followers"] != null) {
            followersCount = snapshot.data["followers"].length;
          }
          // Checking if it is Current User's profile
          if (providedUID != null) {
            isAlreadyFollowing(providedUID);
          }

          return Column(
            children: [
              photoURL == ""
                  ? Container(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          const Radius.circular(75.0),
                        ),
                      ),
                      height: 100,
                      width: 100,
                    )
                  : ProfilePhoto(
                      radius: 50,
                      photoURL: photoURL,
                    ),
              if (firstName != "" && lastName != "")
                Text(
                  "$firstName $lastName",
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              Text(
                "Skin type: $skinType",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "$followersCount подписчиков",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) {
                          return FollowersScreen(
                            count: followersCount,
                            categoryName: "подписчиков",
                            uids: snapshot.data["followers"],
                          );
                        },
                      ));
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "$followingCount подписок",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) {
                          return FollowersScreen(
                            count: followingCount,
                            categoryName: "подписки",
                            uids: snapshot.data["following"],
                          );
                        },
                      ));
                    },
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
