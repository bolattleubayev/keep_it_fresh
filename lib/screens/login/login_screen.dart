import 'package:flutter/material.dart';

import '../../widgets/google_sign_in_button.dart';
import '../../widgets/email_sign_in_button.dart';
import '../signup/check_username_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.white,
        child: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color.fromRGBO(93, 23, 233, 1),
                  const Color.fromRGBO(160, 122, 252, 1),
                ],
                begin: const FractionalOffset(0.0, 0.4),
                end: const FractionalOffset(0.6, 0.0),
                stops: [-1, 1],
                tileMode: TileMode.clamp),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset("assets/images/logo.png"),
                SizedBox(
                  height: 50,
                ),
                GoogleSignInButton(),
                SizedBox(
                  height: 10,
                ),
                EmailSignInButton(),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          "Создать профиль",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.deepPurpleAccent,
                              ),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return CheckUsernameScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
