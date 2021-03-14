import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keep_it_fresh/auth/sign_up.dart';

import '../widgets/profile_photo.dart';
import '../widgets/star_rating.dart';

import '../screens/add_item_screen.dart';
import '../screens/comments_screen.dart';

class ItemScreen extends StatefulWidget {
  final Map<String, dynamic> itemData;
  final bool isCurrentUser;

  ItemScreen({@required this.isCurrentUser, this.itemData});

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat().add_yMd();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Keep it Fresh",
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.deepPurpleAccent,
                      ),
                ),
                Text(
                  "${widget.itemData["title"]}",
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepPurpleAccent,
                      ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.deepPurpleAccent, //change your color here
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                ProfilePhoto(
                  radius: 100,
                  photoURL: widget.itemData["photoURL"],
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "добавлено ${formatter.format(DateTime.parse(widget.itemData["creationDate"]))}",
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
            if (widget.isCurrentUser)
              FlatButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return AddItemScreen(
                          isEditing: true,
                          editedItemData: widget.itemData,
                        );
                      },
                    ),
                  );
                },
                child: Text(
                  "Редактировать",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Colors.deepPurple),
                ),
              ),
            SizedBox(
              height: 8,
            ),
            Card(
              color: Color.fromRGBO(174, 142, 255, 1),
              elevation: 7,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.itemData["productType"]}",
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(color: Colors.white70),
                      textAlign: TextAlign.start,
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Бренд",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          "${widget.itemData["brand"]}",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Штрих-код",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          "${widget.itemData["barcode"]}",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Срок годности",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          "${widget.itemData["edOpen"]} мес",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Средняя оценка",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                        FutureBuilder(
                          future: getAverageRating(
                              userID: widget.itemData["userID"],
                              itemID: widget.itemData["itemID"]),
                          builder: (ctx, snapshot) {
                            return Text(
                              "${snapshot.data.toStringAsFixed(1)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: Colors.white),
                            );
                          },
                        ),
                      ],
                    ),
                    Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Описание",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          "${widget.itemData["description"]}",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: getMyRating(
                  userID: widget.itemData["userID"],
                  itemID: widget.itemData["itemID"]),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  rating = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Рейтинг",
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                color: Colors.deepPurpleAccent,
                              ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        StarRating(
                            starSize: 30,
                            rating: rating,
                            onRatingChanged: (rating) async {
                              await addRating(
                                userID: widget.itemData["userID"],
                                itemID: widget.itemData["itemID"],
                                rating: rating,
                              );
                              setState(() {
                                this.rating = rating;
                              });
                            }),
                      ],
                    ),
                  );
                }
              },
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Color.fromRGBO(174, 142, 255, 1),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Показать отзывы",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return CommentsScreen(
                    userID: widget.itemData["userID"],
                    username: widget.itemData["username"],
                    itemID: widget.itemData["itemID"],
                  );
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
