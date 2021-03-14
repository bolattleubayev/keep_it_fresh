import 'package:flutter/material.dart';
import '../widgets/app_bar_title.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  CustomAppBar({@required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: AppBarTitle(
        title: title,
      ),
      backgroundColor: Color.fromRGBO(174, 142, 255, 1),
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
