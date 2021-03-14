import 'package:flutter/material.dart';

class SignUpTextFormField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboard;

  SignUpTextFormField({
    this.hintText,
    this.textController,
    this.obscureText,
    this.keyboard = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        style:
            Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
        keyboardType: keyboard,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter ' + hintText;
          }
          if (value.length < 6 && hintText == 'password') {
            return 'Password is too short';
          }
          if (!value.contains('@') && hintText == 'email') {
            return 'Please enter a valid email';
          }
          return null;
        },
        controller: textController,
        obscureText: obscureText,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          border: OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(100.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(100.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(100.0),
          ),
        ),
      ),
    );
  }
}
