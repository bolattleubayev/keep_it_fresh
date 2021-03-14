import 'package:flutter/material.dart';
import 'package:keep_it_fresh/widgets/users_search_list.dart';
import '../models/item.dart';
import '../auth/sign_up.dart';
import '../widgets/users_search_list.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  List<Item> shownItems = Item.dummyData;
  List<Item> allDummyItems = Item.dummyData;

  List<Map<String, String>> userDataList = [];

  final searchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(174, 142, 255, 1),
                borderRadius: new BorderRadius.only(
                  bottomLeft: const Radius.circular(20.0),
                  bottomRight: const Radius.circular(20.0),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: searchFieldController,
                          decoration: InputDecoration(
                            focusColor: Colors.deepPurple,
                            hoverColor: Colors.deepPurple,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(70.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 0.0,
                              ),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.person_add),
                          ),
                          onChanged: (text) async {
                            userDataList =
                                await getDataForSearch(username: text);

                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          userDataList == []
              ? Text(
                  "Поиск пользователей",
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        color: Colors.white,
                      ),
                )
              : UserSearchList(
                  items: userDataList,
                ),
        ],
      ),
    );
  }
}
