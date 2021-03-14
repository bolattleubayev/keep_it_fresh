import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../auth/sign_up.dart';
import '../screens/item_screen.dart';
import '../widgets/custom_drop_down_menu.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  String dropdownValue = 'все';
  List<String> sortedUsernames = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(174, 142, 255, 1),
              borderRadius: new BorderRadius.only(
                bottomLeft: const Radius.circular(20.0),
                bottomRight: const Radius.circular(20.0),
              ),
            ),
            padding: EdgeInsets.only(bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Тип кожи",
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.white,
                      ),
                ),
                CustomDropDownMenu(
                  initialValue: dropdownValue,
                  menuItems: [
                    'все',
                    'нормальная',
                    'сухая',
                    'жирная',
                    'комбинированная'
                  ],
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
          Flexible(
            child: FutureBuilder(
              future: getFeedItems(sortBy: dropdownValue),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  // Sort by date, latest first
                  List<Map<String, dynamic>> firData =
                      List<Map<String, dynamic>>.from(snapshot.data);
                  firData.sort((m1, m2) {
                    return m1["creationDate"].compareTo(m2["creationDate"]);
                  });
                  firData = firData.reversed.toList();

                  return ListView.builder(
                      itemCount: firData.length,
                      itemBuilder: (ctx, index) {
                        final String photoURL = firData[index]["photoURL"];
                        return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: new BorderRadius.all(
                                  const Radius.circular(20.0),
                                ),
                                border: Border.all(
                                  color: Colors.deepPurpleAccent,
                                  width: 3.0,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "${firData[index]["username"]} добавил ${formatter.format(DateTime.parse(firData[index]["creationDate"]))}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                            color: Colors.deepPurpleAccent),
                                  ),
                                  Container(
                                    height: 200,
                                    width: double.infinity,
                                    child: ClipRect(
                                      child: photoURL == ""
                                          ? Icon(Icons.photo, size: 50)
                                          : Image.network(
                                              photoURL,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  Text(
                                    firData[index]["title"],
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(
                                            color: Colors.deepPurpleAccent),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return ItemScreen(
                                isCurrentUser: false,
                                itemData: firData[index],
                              );
                            }));
                          },
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
