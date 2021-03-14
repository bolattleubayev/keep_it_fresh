import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../auth/sign_up.dart';
import '../constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/sign_up_text_form_field.dart';
import '../widgets/profile_photo.dart';
import '../widgets/custom_drop_down_menu.dart';

class OtherPreferencesScreen extends StatefulWidget {
  @override
  _OtherPreferencesScreenState createState() => _OtherPreferencesScreenState();
}

class _OtherPreferencesScreenState extends State<OtherPreferencesScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  String skinType = 'нормальная';
  String photoURL = '';
  DateTime birthDate = DateTime.now();
  final locationController = TextEditingController();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: birthDate, // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: "Выберите дату",
    );
    if (picked != null && picked != birthDate)
      setState(() {
        birthDate = picked;
      });
  }

  Future<String> uploadPic() async {
    //Get the file from the image picker and store it
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    File file = File(pickedFile.path);

    //Create a reference to the location you want to upload to in firebase
    StorageReference reference = _storage
        .ref()
        .child("profile_photos")
        .child("${_auth.currentUser.uid}.png");

    //Upload the file to firebase
    await reference.putFile(file).onComplete;

    final url = await reference.getDownloadURL();
    return url;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Профиль",
      ),
      body: FutureBuilder(
        future: retrieveUserData(isCurrentUser: true),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            firstNameController.text = snapshot.data["firstName"] == null
                ? firstNameController.text = ""
                : firstNameController.text = snapshot.data["firstName"];
            lastNameController.text = snapshot.data["lastName"] == null
                ? lastNameController.text = ""
                : lastNameController.text = snapshot.data["lastName"];
            locationController.text = snapshot.data["location"] == null
                ? locationController.text = ""
                : locationController.text = snapshot.data["location"];
            skinType = snapshot.data["skinType"] == null
                ? skinType = "нормальная"
                : skinType = snapshot.data["skinType"];
            birthDate = snapshot.data["birthDate"] == null
                ? birthDate = DateTime.now()
                : birthDate = DateTime.parse(snapshot.data["birthDate"]);
            photoURL = snapshot.data["photoURL"] == null
                ? photoURL = ""
                : photoURL = snapshot.data["photoURL"];
            return SingleChildScrollView(
              child: Container(
                color: Color.fromRGBO(174, 142, 255, 1),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        (photoURL == "")
                            ? Container(
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    const Radius.circular(75.0),
                                  ),
                                ),
                                height: 150,
                                width: 150,
                              )
                            : ProfilePhoto(
                                photoURL: photoURL,
                                radius: 75.0,
                              ),
                        FlatButton(
                          child: Text(
                            "Загрузить свое фото",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.white),
                          ),
                          onPressed: () async {
                            photoURL = await uploadPic();
                          },
                        ),
                        SignUpTextFormField(
                          hintText: "имя",
                          textController: firstNameController,
                          obscureText: false,
                        ),
                        SignUpTextFormField(
                          hintText: "фамилия",
                          textController: lastNameController,
                          obscureText: false,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Тип кожи",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: Colors.white),
                              ),
                              Flexible(
                                child: CustomDropDownMenu(
                                  initialValue: skinType,
                                  menuItems: <String>[
                                    'нормальная',
                                    'сухая',
                                    'жирная',
                                    'комбинированная'
                                  ],
                                  onChanged: (String newValue) {
                                    setState(() {
                                      skinType = newValue;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Дата\nрождения",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: Colors.white),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${formatter.format(birthDate)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(color: Colors.white),
                                  ),
                                  FlatButton(
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      _selectDate(context);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SignUpTextFormField(
                          hintText: "регион",
                          textController: locationController,
                          obscureText: false,
                        ),
                        FlatButton(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Сохранить профиль",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                    color: Color.fromRGBO(174, 142, 255, 1),
                                  ),
                            ),
                          ),
                          onPressed: () async {
                            // Validate returns true if the form is valid, otherwise false.
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, call a server and save the information in a database.
                              addUserData(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                photoURL: photoURL,
                                skinType: skinType,
                                birthDate: birthDate.toIso8601String(),
                                location: locationController.text,
                              );
//                                widget.rebuildPicture();
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    firstNameController.dispose();
    lastNameController.dispose();
    locationController.dispose();
    super.dispose();
  }
}
