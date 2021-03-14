import 'package:flutter/material.dart';
import '../auth/sign_in.dart';
import '../screens/tabs_screen.dart';

class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: RaisedButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        onPressed: () {
          signInWithGoogle().whenComplete(() {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return TabsScreen();
                },
              ),
            );
          });
        },
        highlightElevation: 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                  image: AssetImage("assets/images/google_logo.png"),
                  height: 35.0),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Войти с Google',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
