import 'package:flutter/material.dart';

import '../auth/sign_up.dart';
import '../screens/other_preferences_screen.dart';
import '../widgets/user_items_grid.dart';
import '../widgets/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String photoURL = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Flexible(
            child: Container(
              constraints:
                  BoxConstraints(minHeight: 200, minWidth: double.infinity),
              decoration: BoxDecoration(
                color: Color.fromRGBO(174, 142, 255, 1),
                borderRadius: new BorderRadius.only(
                  bottomLeft: const Radius.circular(40.0),
                  bottomRight: const Radius.circular(40.0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileHeader(
                    isCurrentUser: true,
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlatButton(
                          child: Container(
                            child: Text(
                              "Редактировать профиль",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      color:
                                          Colors.deepPurple.withOpacity(0.6)),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) {
                                  return OtherPreferencesScreen();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder(
            future: retrieveUserItems(isCurrentUser: true),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                List<Map<String, dynamic>> firData =
                    List<Map<String, dynamic>>.from(snapshot.data);
                return UserItemsGrid(
                  items: firData,
                  isCurrentUserItems: true,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
