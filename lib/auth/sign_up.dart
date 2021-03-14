//import 'dart:html';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final databaseReference = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseStorage _storage = FirebaseStorage.instance;
var uuid = Uuid();

Future<bool> isUsernameAvailable({String username}) async {
  DocumentSnapshot snp =
      await databaseReference.collection("usernames").doc(username).get();

  if (snp.data() == null) {
    return true;
  } else {
    return false;
  }
}

Future<String> getUsername({uid}) async {
  Query snp = await FirebaseFirestore.instance
      .collection("usernames")
      .where("uid", isEqualTo: uid);

  Stream<QuerySnapshot> snps = snp.snapshots();

  return (await snps.first).docs.first.data()["username"];
}

Future<List<Map<String, dynamic>>> getFeedItems(
    {@required String sortBy}) async {
  final User currentUser = _auth.currentUser;
  String currentUserID = currentUser.uid;
  List<Map<String, dynamic>> returnArray = [];

  DocumentSnapshot snp = await FirebaseFirestore.instance
      .collection("userdata")
      .doc(currentUserID)
      .get();

  if (snp.data() != null) {
    final followingArray = snp.data()["following"];

    if (followingArray != null) {
      for (var followingUID in followingArray) {
        if (sortBy == 'все') {
          QuerySnapshot querySnp = await databaseReference
              .collection("useritems")
              .doc(followingUID)
              .collection('items')
              .get();

          final queryArray = querySnp.docs;

          for (var item in queryArray) {
            returnArray.add(item.data());
          }
        } else {
          DocumentSnapshot snp = await FirebaseFirestore.instance
              .collection("userdata")
              .doc(followingUID)
              .get();
          if (snp.data()["skinType"] == sortBy) {
            QuerySnapshot querySnp = await databaseReference
                .collection("useritems")
                .doc(followingUID)
                .collection('items')
                .get();

            final queryArray = querySnp.docs;

            for (var item in queryArray) {
              returnArray.add(item.data());
            }
          }
        }
      }
      return returnArray;
    }
  }

  return returnArray;
}

Future<void> addComment(
    {String userID, String username, String itemID, String commentText}) async {
  final String currentUID = _auth.currentUser.uid;
  final String usrName = await getUsername(uid: currentUID);

  await databaseReference
      .collection("useritems")
      .doc(userID)
      .collection('items')
      .doc(itemID)
      .collection("comments")
      .add({
    "authorUID": currentUID,
    "username": usrName,
    "text": commentText,
    "date": DateTime.now().toIso8601String()
  });
}

Future<List<Map<String, dynamic>>> getComments(
    {String userID, String username, String itemID}) async {
  List<Map<String, dynamic>> returnArray = [];

  QuerySnapshot snp = await databaseReference
      .collection("useritems")
      .doc(userID)
      .collection('items')
      .doc(itemID)
      .collection("comments")
      .get();

  if (snp.docs.toList().isNotEmpty) {
    List<QueryDocumentSnapshot> commentSnapshots = snp.docs.toList();

    List<Map<String, String>> comments = [];

    for (var comment in commentSnapshots) {
      comments.add({
        "username": comment.data()["username"],
        "text": comment.data()["text"],
        "date": comment.data()["date"],
      });
    }

    comments.sort((m1, m2) {
      return m1["date"].compareTo(m2["date"]);
    });

    returnArray = comments;
  }

  return returnArray;
}

Future<void> addRating({String userID, String itemID, double rating}) async {
  final String currentUID = _auth.currentUser.uid;
  final String usrName = await getUsername(uid: currentUID);

  await databaseReference
      .collection("useritems")
      .doc(userID)
      .collection('items')
      .doc(itemID)
      .collection("ratings")
      .doc(currentUID)
      .set({
    "authorUID": currentUID,
    "username": usrName,
    "date": DateTime.now().toIso8601String(),
    "rating": "$rating",
  });
}

Future<double> getMyRating({String userID, String itemID}) async {
  final String currentUID = _auth.currentUser.uid;

  DocumentSnapshot snp = await databaseReference
      .collection("useritems")
      .doc(userID)
      .collection('items')
      .doc(itemID)
      .collection("ratings")
      .doc(currentUID)
      .get();

  if (snp.data() == null) {
    return 0.0;
  } else {
    return double.parse(snp.data()["rating"]);
  }
}

Future<double> getAverageRating({String userID, String itemID}) async {
  final String currentUID = _auth.currentUser.uid;

  QuerySnapshot snp = await databaseReference
      .collection("useritems")
      .doc(userID)
      .collection('items')
      .doc(itemID)
      .collection("ratings")
      .get();

  if (snp.docs.toList().isNotEmpty) {
    List<QueryDocumentSnapshot> ratingsSnapshots = snp.docs.toList();

    double ratings = 0.0;

    for (var rating in ratingsSnapshots) {
      ratings += double.parse(rating.data()["rating"]);
    }
    return ratings / ratingsSnapshots.length;
  }

  return 0.0;
}

Future<List<Map<String, String>>> getDataForSearch({String username}) async {
  QuerySnapshot snp = await databaseReference
      .collection("usernames")
      .orderBy("username")
      .startAt([username]).endAt([username + '\uf8ff']).get();

  if (snp.docs == null) {
    return [];
  } else {
    List<Map<String, String>> returnList = [];

    for (var document in snp.docs.toList()) {
      final String uid = document.data()["uid"];
      final String fullUsername = document.data()["username"];

      DocumentSnapshot userDataSnapshot =
          await databaseReference.collection("userdata").doc(uid).get();

      returnList.add({
        "uid": uid,
        "username": fullUsername,
        "photoURL": userDataSnapshot.data()["photoURL"],
      });
    }

    return returnList;
  }
}

Future<List<Map<String, String>>> getFollowData({List<String> uids}) async {
  List<Map<String, String>> returnList = [];

  for (var uid in uids) {
    DocumentSnapshot userDataSnapshot =
        await databaseReference.collection("userdata").doc(uid).get();

    returnList.add({
      "uid": uid,
      "username": userDataSnapshot.data()["username"],
      "photoURL": userDataSnapshot.data()["photoURL"],
    });
  }

  return returnList;
}

Future<DocumentSnapshot> addUsername(
    {String username, String uid, String email}) async {
  DocumentSnapshot snp =
      await databaseReference.collection("usernames").doc(username).get();

  // If no such username
  if (snp.data() == null) {
    // Adding username to usernames list for uniqueness check
    await databaseReference.collection("usernames").doc(username).set({
      'uid': uid,
      'username': username,
    });
  }

  return snp;
}

bool isCurrentUser(String uid) {
  final User currentUser = _auth.currentUser;
  if (uid == currentUser.uid) {
    return true;
  } else {
    return false;
  }
}

Future<bool> isAlreadyFollowing(String uid) async {
  final User currentUser = _auth.currentUser;
  String currentUserID = currentUser.uid;

  DocumentSnapshot snp =
      await FirebaseFirestore.instance.collection("userdata").doc(uid).get();

  if (snp.data()["followers"] != null) {
    if (snp.data()["followers"].contains(currentUserID)) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}

void followUser(String followUID) async {
  final User currentUser = _auth.currentUser;
  String currentUserID = currentUser.uid;

  // add to followers of followed user, without repetition
  FirebaseFirestore.instance.collection("userdata").doc(followUID).update({
    "followers": FieldValue.arrayUnion([currentUserID])
  });
  // add to following of following user, without repetition
  FirebaseFirestore.instance.collection("userdata").doc(currentUserID).update({
    "following": FieldValue.arrayUnion([followUID])
  });
}

void unfollowUser(String followUID) async {
  final User currentUser = _auth.currentUser;
  String currentUserID = currentUser.uid;

  // remove to followers of followed user, without repetition
  FirebaseFirestore.instance.collection("userdata").doc(followUID).update({
    "followers": FieldValue.arrayRemove([currentUserID])
  });
  // remove to following of following user, without repetition
  FirebaseFirestore.instance.collection("userdata").doc(currentUserID).update({
    "following": FieldValue.arrayRemove([followUID])
  });
}

void addUserData({
  String firstName,
  String lastName,
  String photoURL,
  String skinType,
  String birthDate,
  String location,
}) async {
  final User currentUser = _auth.currentUser;
  String uid = currentUser.uid;
  String username = await getUsername(uid: uid);

  await databaseReference.collection("userdata").doc(uid).set(
    {
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'photoURL': photoURL,
      'email': currentUser.email,
      'skinType': skinType,
      'birthDate': birthDate,
      'location': location,
    },
    SetOptions(merge: true),
  );
}

Future<Map<String, dynamic>> retrieveUserData(
    {@required bool isCurrentUser, String providedUID}) async {
  if (isCurrentUser) {
    final User currentUser = _auth.currentUser;
    String uid = currentUser.uid;
    DocumentSnapshot snp =
        await databaseReference.collection("userdata").doc(uid).get();

    if (snp.data() != null) {
      return snp.data();
    } else {
      return {"": ""};
    }
  } else {
    DocumentSnapshot snp =
        await databaseReference.collection("userdata").doc(providedUID).get();

    if (snp.data() != null) {
      return snp.data();
    } else {
      return {"": ""};
    }
  }
}

Future<List<Map<String, dynamic>>> retrieveUserItems(
    {bool isCurrentUser, String providedUID}) async {
  if (isCurrentUser) {
    final User currentUser = _auth.currentUser;
    List<Map<String, dynamic>> items = [];

    String uid = currentUser.uid;
    QuerySnapshot snp = await databaseReference
        .collection("useritems")
        .doc(uid)
        .collection('items')
        .get();

    snp.docs.toList().forEach((element) {
      items.add(element.data());
    });

    return items;
  } else {
    List<Map<String, dynamic>> items = [];

    QuerySnapshot snp = await databaseReference
        .collection("useritems")
        .doc(providedUID)
        .collection('items')
        .get();

    snp.docs.toList().forEach((element) {
      items.add(element.data());
    });

    return items;
  }
}

Future<User> signUpEmail(email, username, password) async {
  // Sign Up new user
  UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email, password: password);
  final User user = result.user;

  assert(user != null);
  assert(await user.getIdToken() != null);

  // Verify uniqueness of the username
  DocumentSnapshot snp =
      await addUsername(username: username, uid: user.uid, email: email);

  // If username is taken, remove userdata
  if (snp.data() != null) {
    user.delete();
  }
  assert(snp.data() == null);

  await user.updateProfile(displayName: username);
  await user.reload();

  return user;
}

// Adding items
Future<String> uploadPic() async {
  //Get the file from the image picker and store it
  final imagePicker = ImagePicker();
  final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
  File file = File(pickedFile.path);

  //Create a reference to the location you want to upload to in firebase
  StorageReference reference = _storage
      .ref()
      .child("user_item_photos")
      .child(_auth.currentUser.uid)
      .child("${uuid.v4()}.png");

  //Upload the file to firebase
  await reference.putFile(file).onComplete;

  final url = await reference.getDownloadURL();
  //returns the download url
  return url;
}

void addUserItem({
  String photoURL,
  String title,
  String brand,
  String productType,
  String barcode,
  String description,
  String edOpen,
  String edClosed,
  String openDate,
}) async {
  final User currentUser = _auth.currentUser;
  String uid = currentUser.uid;
  String username = await getUsername(uid: uid);
  String itemId = uuid.v4();
  // If no such username
  await databaseReference
      .collection("useritems")
      .doc(uid)
      .collection('items')
      .doc(itemId)
      .set({
    'itemID': itemId,
    'userID': uid,
    'username': username,
    'photoURL': photoURL,
    'title': title,
    'brand': brand,
    'productType': productType,
    'barcode': barcode,
    'description': description,
    'edOpen': edOpen,
    'edClosed': edClosed,
    'openDate': openDate,
    'creationDate': DateTime.now().toIso8601String(),
  });
}

void editUserItem({
  String itemID,
  String photoURL,
  String title,
  String brand,
  String productType,
  String barcode,
  String description,
  String edOpen,
  String edClosed,
  String openDate,
}) async {
  final User currentUser = _auth.currentUser;
  String uid = currentUser.uid;
  String username = await getUsername(uid: uid);
  // If no such username
  await databaseReference
      .collection("useritems")
      .doc(uid)
      .collection('items')
      .doc(itemID)
      .set({
    'itemID': itemID,
    'userID': uid,
    'username': username,
    'photoURL': photoURL,
    'title': title,
    'brand': brand,
    'productType': productType,
    'barcode': barcode,
    'description': description,
    'edOpen': edOpen,
    'edClosed': edClosed,
    'openDate': openDate,
    'creationDate': DateTime.now().toIso8601String(),
  });
}
