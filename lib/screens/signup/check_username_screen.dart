import 'package:flutter/material.dart';
import 'package:keep_it_fresh/widgets/custom_app_bar.dart';

import '../../auth/sign_up.dart';
import '../../widgets/app_bar_title.dart';
import '../../widgets/sign_up_text_form_field.dart';
import 'contact_info_screen.dart';

class CheckUsernameScreen extends StatefulWidget {
  @override
  _CheckUsernameScreenState createState() => _CheckUsernameScreenState();
}

class _CheckUsernameScreenState extends State<CheckUsernameScreen> {
  final usernameController = TextEditingController();

  final _globalKeyForSnackBar = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKeyForSnackBar,
      backgroundColor: const Color.fromRGBO(93, 23, 233, 1),
      appBar: CustomAppBar(
        title: "Имя пользователя",
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
                    hintText: "username",
                    textController: usernameController,
                    obscureText: false,
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
                          "Далее",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: Colors.deepPurpleAccent,
                              ),
                        ),
                      ),
                      onPressed: () async {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, call a server and save the information in a database.
                          if (await isUsernameAvailable(
                              username: usernameController.text)) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ContactInfoScreen(
                                    username: usernameController.text,
                                  );
                                },
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: Text("Упс..."),
                                  content:
                                      Text("Это имя пользователя уже занято"),
                                  actions: [
                                    FlatButton(
                                      child: Text('Хорошо'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
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
    usernameController.dispose();
    super.dispose();
  }
}
