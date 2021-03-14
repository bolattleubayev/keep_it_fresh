import 'package:flutter/material.dart';

import '../screens/item_screen.dart';
import '../screens/add_item_screen.dart';

class UserItemsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final bool isCurrentUserItems;

  UserItemsGrid({
    @required this.items,
    @required this.isCurrentUserItems,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.9,
          ),
          itemCount: isCurrentUserItems ? items.length + 1 : items.length,
          itemBuilder: (ctx, index) {
            if (isCurrentUserItems) {
              if (index == 0) {
                return GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: GridTile(
                        child: Container(
                          color: Colors.grey,
                          child: Center(
                            child: Text(
                              "+ Новый продукт",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(color: Colors.deepPurple),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                          return AddItemScreen(
                            isEditing: false,
                          );
                        },
                      ),
                    );
                  },
                );
              } else {
                return GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: GridTile(
                        child: items[index - 1]["photoURL"] == ""
                            ? Icon(Icons.satellite)
                            : Image.network(
                                items[index - 1]["photoURL"],
                                fit: BoxFit.cover,
                              ),
                        footer: Container(
                          height: 50.0,
                          color: Colors.black54,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              child: Text(
                                items[index - 1]["title"],
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (!isCurrentUserItems) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) {
                            return ItemScreen(
                                isCurrentUser: false,
                                itemData: items[index - 1]);
                          },
                        ),
                      );
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) {
//                            return AddItemScreen(
//                              isEditing: true,
//                              editedItemData: items[index - 1],
//                            );
                            return ItemScreen(
                              isCurrentUser: true,
                              itemData: items[index - 1],
                            );
                          },
                        ),
                      );
                    }
                  },
                );
              }
            } else {
              return GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: GridTile(
                      child: items[index]["photoURL"] == ""
                          ? Icon(Icons.satellite)
                          : Image.network(
                              items[index]["photoURL"],
                              fit: BoxFit.cover,
                            ),
                      footer: Container(
                        height: 50.0,
                        color: Colors.black54,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Text(
                              items[index]["title"],
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  if (!isCurrentUserItems) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                          return ItemScreen(
                              isCurrentUser: false, itemData: items[index]);
                        },
                      ),
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                          return AddItemScreen(
                            isEditing: true,
                            editedItemData: items[index],
                          );
                        },
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
