import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final bool obscureText;

  LoginTextField({
    this.hintText,
    this.textController,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextField(
        style:
            Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
        controller: textController,
        obscureText: obscureText,
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
