import 'package:flutter/material.dart';

import '../../widgets/custom_app_bar.dart';
import '../../auth/sign_in.dart';
import '../../widgets/app_bar_title.dart';
import '../../widgets/login_text_field.dart';
import '../tabs_screen.dart';

class EmailLoginScreen extends StatefulWidget {
  @override
  _EmailLoginScreenState createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Почта",
      ),
      body: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                const Color.fromRGBO(93, 23, 233, 1),
                const Color.fromRGBO(174, 142, 255, 1)
              ],
              begin: const FractionalOffset(0.0, 1),
              end: const FractionalOffset(0.0, 0.0),
              stops: [-1, 1],
              tileMode: TileMode.clamp),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset("assets/images/logo.png"),
                SizedBox(
                  height: 20,
                ),
                LoginTextField(
                  hintText: "почта",
                  textController: emailController,
                  obscureText: false,
                ),
                LoginTextField(
                  hintText: "пароль",
                  textController: passwordController,
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "Вход",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.deepPurpleAccent,
                            ),
                      ),
                    ),
                    onPressed: () {
                      signInEmail(emailController.text, passwordController.text)
                          .whenComplete(() {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) {
                              return TabsScreen();
                            },
                          ),
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
