import 'package:flutter/material.dart';
import 'package:keep_it_fresh/auth/sign_up.dart';

import '../constants.dart';
import '../auth/sign_up.dart';
import '../widgets/sign_up_text_form_field.dart';
import '../widgets/profile_photo.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drop_down_menu.dart';
// barcode
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AddItemScreen extends StatefulWidget {
//  final Function rebuildItems;

  final bool isEditing;
  final Map<String, dynamic> editedItemData;

  AddItemScreen({@required this.isEditing, this.editedItemData});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  String photoURL = '';
  final titleController = TextEditingController();
  final brandController = TextEditingController();
  String productType = '';
  final barcodeController = TextEditingController();
  final descriptionController = TextEditingController();
  String monthsSinceOpening = '0';

  DateTime expiryDate = DateTime.now();
  DateTime openedDate = DateTime.now();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  Future<DateTime> _selectDate(
      BuildContext context, DateTime initialDate) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate, // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      helpText: "Выберите дату",
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      barcodeController.text = barcodeScanRes;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.isEditing) {
      photoURL = widget.editedItemData["photoURL"];
      titleController.text = widget.editedItemData["title"];
      brandController.text = widget.editedItemData["brand"];
      productType = widget.editedItemData["productType"];
      barcodeController.text = widget.editedItemData["barcode"];
      descriptionController.text = widget.editedItemData["description"];
      monthsSinceOpening = widget.editedItemData["edOpen"];
      expiryDate = DateTime.parse(widget.editedItemData["edClosed"]);
      openedDate = DateTime.parse(widget.editedItemData["openDate"]);
    } else {
      productType = 'крем';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.isEditing ? "Редактировать" : "Добавить",
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 10,
            left: 10,
            right: 10,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // photo
                photoURL == ""
                    ? Container(
                        decoration: new BoxDecoration(
                          color: Color.fromRGBO(174, 142, 255, 1),
                          border: Border.all(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.all(
                            const Radius.circular(75.0),
                          ),
                        ),
                        height: 150,
                        width: 150,
                      )
                    : ProfilePhoto(
                        photoURL: photoURL,
                        radius: 50,
                      ),
                FlatButton(
                  child: Text(
                    "Выбрать фото",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () async {
                    photoURL = await uploadPic();
                    setState(() {});
                  },
                ),
                // title
                SignUpTextFormField(
                  hintText: "название",
                  textController: titleController,
                  obscureText: false,
                ),

                // brand
                SignUpTextFormField(
                  hintText: "бренд",
                  textController: brandController,
                  obscureText: false,
                ),
                // product type
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Тип продукта",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      Flexible(
                        child: CustomDropDownMenu(
                          initialValue: productType,
                          menuItems: <String>[
                            'крем',
                            'помада',
                            'шампунь',
                            'масло'
                          ],
                          onChanged: (String newValue) {
                            setState(() {
                              productType = newValue;
                            });
                          },
                        ),
                      ),
//                      Flexible(
//                        child: DropdownButton<String>(
//                          value: productType,
//                          icon: Icon(Icons.arrow_downward),
//                          iconSize: 24,
//                          elevation: 16,
//                          style: TextStyle(color: Colors.deepPurple),
//                          underline: Container(
//                            height: 2,
//                            color: Colors.deepPurpleAccent,
//                          ),
//                          onChanged: (String newValue) {
//                            setState(() {
//                              productType = newValue;
//                            });
//                          },
//                          items: <String>['cream', 'lipstick', 'powder', 'oil']
//                              .map<DropdownMenuItem<String>>((String value) {
//                            return DropdownMenuItem<String>(
//                              value: value,
//                              child: Text(
//                                value,
//                                style: TextStyle(fontSize: 20),
//                              ),
//                            );
//                          }).toList(),
//                        ),
//                      ),
                    ],
                  ),
                ),
                // barcode
                Row(
                  children: [
                    Flexible(
                      child: SignUpTextFormField(
                        hintText: "штрих-код",
                        textController: barcodeController,
                        obscureText: false,
                      ),
                    ),
                    FlatButton(
                      child: Icon(
                        Icons.fullscreen,
                        color: Colors.white,
                        size: 40.0,
                      ),
                      onPressed: () {
                        scanBarcodeNormal();
                      },
                    ),
                  ],
                ),
                // description
                SignUpTextFormField(
                  hintText: "описание",
                  textController: descriptionController,
                  obscureText: false,
                ),
                // expiry date in months since opening
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Срок годности\nпосле вскрытия",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      Flexible(
                        child: CustomDropDownMenu(
                          initialValue: monthsSinceOpening,
                          menuItems: monthsDropDownValues,
                          onChanged: (String newValue) {
                            setState(() {
                              monthsSinceOpening = newValue;
                            });
                          },
                        ),
                      ),
//                      Flexible(
//                        child: DropdownButton<String>(
//                          value: monthsSinceOpening,
//                          icon: Icon(Icons.arrow_downward),
//                          iconSize: 24,
//                          elevation: 16,
//                          style: TextStyle(color: Colors.deepPurple),
//                          underline: Container(
//                            height: 2,
//                            color: Colors.deepPurpleAccent,
//                          ),
//                          onChanged: (String newValue) {
//                            setState(() {
//                              monthsSinceOpening = newValue;
//                            });
//                          },
//                          items: monthsDropDownValues
//                              .map<DropdownMenuItem<String>>((String value) {
//                            return DropdownMenuItem<String>(
//                              value: value,
//                              child: Text(
//                                value,
//                                style: TextStyle(fontSize: 20),
//                              ),
//                            );
//                          }).toList(),
//                        ),
//                      ),
                    ],
                  ),
                ),
                // expiry date closed
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "годен до",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${formatter.format(expiryDate)}",
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                          FlatButton(
                            child: Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              DateTime preliminaryExpiryDate =
                                  await _selectDate(context, expiryDate);
                              if (preliminaryExpiryDate != null) {
                                expiryDate = preliminaryExpiryDate;
                              }
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // opened date
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "открыт",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${formatter.format(openedDate)}",
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                          FlatButton(
                            child: Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              DateTime preliminaryOpenedDate =
                                  await _selectDate(context, openedDate);
                              if (preliminaryOpenedDate != null) {
                                openedDate = preliminaryOpenedDate;
                              }
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // send
                FlatButton(
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "Сохранить",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Color.fromRGBO(174, 142, 255, 1),
                          ),
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Validate returns true if the form is valid, otherwise false.
                    if (_formKey.currentState.validate()) {
                      if (widget.isEditing) {
                        editUserItem(
                          itemID: widget.editedItemData["itemID"],
                          photoURL: photoURL,
                          title: titleController.text,
                          barcode: barcodeController.text,
                          brand: brandController.text,
                          productType: productType,
                          description: descriptionController.text,
                          edOpen: monthsSinceOpening,
                          edClosed: expiryDate.toIso8601String(),
                          openDate: openedDate.toIso8601String(),
                        );
                      } else {
                        addUserItem(
                          photoURL: photoURL,
                          title: titleController.text,
                          barcode: barcodeController.text,
                          brand: brandController.text,
                          productType: productType,
                          description: descriptionController.text,
                          edOpen: monthsSinceOpening,
                          edClosed: expiryDate.toIso8601String(),
                          openDate: openedDate.toIso8601String(),
                        );
                      }

//                        widget.rebuildItems();
                      Navigator.of(context).pop();
                    }
                  },
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
