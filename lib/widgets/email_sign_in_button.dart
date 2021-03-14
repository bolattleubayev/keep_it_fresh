import 'package:flutter/material.dart';
import '../auth/sign_in.dart';
import '../screens/login/email_login_screen.dart';

class EmailSignInButton extends StatelessWidget {
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return EmailLoginScreen();
              },
            ),
          );
        },
        highlightElevation: 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.email,
                color: Colors.deepPurpleAccent,
                size: 35.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Войти с почтой',
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
