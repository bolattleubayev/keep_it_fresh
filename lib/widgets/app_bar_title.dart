import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final String title;

  AppBarTitle({this.title});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        children: [
          Text(
            "Keep it Fresh",
            style: Theme.of(context).textTheme.headline1.copyWith(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline1.copyWith(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
