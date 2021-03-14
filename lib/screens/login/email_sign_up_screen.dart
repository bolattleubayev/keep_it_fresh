import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../auth/sign_in.dart';
import '../../widgets/app_bar_title.dart';
import '../../widgets/sign_up_text_form_field.dart';

class EmailSignUpScreen extends StatefulWidget {
  @override
  _EmailSignUpScreenState createState() => _EmailSignUpScreenState();
}

class _EmailSignUpScreenState extends State<EmailSignUpScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(
          title: "Email Login",
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.blueGrey, //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Center(
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
                    hintText: "username",
                    textController: nameController,
                    obscureText: false,
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
                      color: Colors.redAccent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          "Sign Up",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ),
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, call a server and save the information in a database.

                          signUpEmail(
                            emailController.text,
                            nameController.text,
                            passwordController.text,
                          ).then((User user) {
                            Navigator.of(context).pop();
                          }).catchError(
                            (e) {
                              print(e);
                              showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: Text("Uh oh..."),
                                    content: Text(
                                        "Please make sure that your email and username are unique"),
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
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
