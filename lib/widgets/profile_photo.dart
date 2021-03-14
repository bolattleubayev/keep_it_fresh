import 'package:flutter/material.dart';

class ProfilePhoto extends StatelessWidget {
  final double radius;
  final String photoURL;

  ProfilePhoto({
    @required this.radius,
    @required this.photoURL,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: (photoURL != null)
          ? CircleAvatar(
              backgroundImage: NetworkImage(
                photoURL,
              ),
              radius: radius,
              backgroundColor: Colors.transparent,
            )
          : Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  const Radius.circular(75.0),
                ),
              ),
              height: 150,
              width: 150,
            ),
    );
  }
}
