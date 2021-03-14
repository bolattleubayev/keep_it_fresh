import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatefulWidget {
  @override
  _CustomDropDownMenuState createState() => _CustomDropDownMenuState();

  final String initialValue;
  final List<String> menuItems;
  final Function onChanged;

  CustomDropDownMenu({
    this.initialValue,
    this.menuItems,
    this.onChanged,
  });
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(174, 142, 255, 1),
      child: DropdownButton<String>(
        value: widget.initialValue,
        icon: Icon(
          Icons.arrow_downward,
          color: Colors.white,
        ),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.white),
        underline: Container(
          height: 2,
          color: Colors.white,
        ),
        onChanged: widget.onChanged,
        items: widget.menuItems.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 22, color: Colors.deepPurple),
            ),
          );
        }).toList(),
      ),
    );
  }
}
