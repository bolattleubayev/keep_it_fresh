import 'package:flutter/material.dart';
import '../widgets/profile_photo.dart';
import '../screens/discover_profile_screen.dart';

class UserSearchList extends StatelessWidget {
  final List<Map<String, String>> items;

  UserSearchList({
    @required this.items,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (ctx, index) {
            final String username = items[index]["username"];
            return Container(
              height: 80,
              child: ListTile(
                leading: ProfilePhoto(
                  radius: 20,
                  photoURL: items[index]["photoURL"],
                ),
                title: Text(
                  username,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Color.fromRGBO(174, 142, 255, 1),
                      ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return DiscoverProfileScreen(
                          uid: items[index]["uid"],
                          username: username,
                        );
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
