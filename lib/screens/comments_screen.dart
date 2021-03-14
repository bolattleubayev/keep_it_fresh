import 'package:flutter/material.dart';

import '../auth/sign_up.dart';
import '../widgets/custom_app_bar.dart';

class CommentsScreen extends StatefulWidget {
  final String userID;
  final String username;
  final String itemID;

  CommentsScreen({this.userID, this.username, this.itemID});

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getComments(
      userID: widget.userID,
      username: widget.username,
      itemID: widget.itemID,
    );

    return Scaffold(
      appBar: CustomAppBar(
        title: "Отзывы",
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getComments(
                userID: widget.userID,
                username: widget.username,
                itemID: widget.itemID,
              ),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<Map<String, dynamic>> commentData =
                      List<Map<String, dynamic>>.from(snapshot.data);
                  return ListView.builder(
                      itemCount: commentData.length,
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          title: Text(
                            commentData[index]["username"],
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.white70),
                          ),
                          subtitle: Text(
                            commentData[index]["text"],
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.white),
                          ),
                        );
                      });
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 30.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: "комментарий",
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
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await addComment(
                      userID: widget.userID,
                      username: widget.username,
                      itemID: widget.itemID,
                      commentText: commentController.text,
                    );
                    commentController.clear();
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
