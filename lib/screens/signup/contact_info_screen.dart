import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keep_it_fresh/widgets/custom_app_bar.dart';

import '../../auth/sign_up.dart';
import '../../widgets/app_bar_title.dart';
import '../../widgets/sign_up_text_form_field.dart';

class ContactInfoScreen extends StatefulWidget {
  final String username;

  ContactInfoScreen({this.username});

  @override
  _ContactInfoScreenState createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(93, 23, 233, 1),
      appBar: CustomAppBar(
        title: "Создать аккаунт",
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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset("assets/images/logo.png"),
                  SizedBox(
                    height: 20,
                  ),
                  SignUpTextFormField(
                    hintText: "email",
                    textController: emailController,
                    obscureText: false,
                  ),
                  SignUpTextFormField(
                    hintText: "password",
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
                          "Создать аккаунт",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: Colors.deepPurpleAccent,
                              ),
                        ),
                      ),
                      onPressed: () async {
                        // If the form is valid, call a server and save the information in a database.
                        if (await isUsernameAvailable()) {
                          signUpEmail(
                            emailController.text,
                            widget.username,
                            passwordController.text,
                          ).then((User user) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          }).catchError(
                            (e) {
                              print(e);
                              showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: Text("Упс..."),
                                    content: Text("Ошибка почты"),
                                    actions: [
                                      FlatButton(
                                        child: Text('Okay'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
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
