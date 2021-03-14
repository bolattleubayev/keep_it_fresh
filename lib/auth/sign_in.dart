import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final databaseReference = FirebaseFirestore.instance;

// Info retrieved from the FirebaseUser
String name;
String email;
String imageUrl;

Future<DocumentSnapshot> addUsername(
    {String username, String uid, String email}) async {
  DocumentSnapshot snp =
      await databaseReference.collection("usernames").doc(username).get();

  // If no such username
  if (snp.data == null) {
    // Adding username to usernames list for uniqueness check
    await databaseReference.collection("usernames").doc(username).set({
      'uid': uid,
    });
  }

  return snp;
}

Future<User> signInEmail(String email, String password) async {
  UserCredential result =
      await _auth.signInWithEmailAndPassword(email: email, password: password);
  final User user = result.user;

  assert(user != null);
  assert(await user.getIdToken() != null);

  final User currentUser = _auth.currentUser;
  assert(user.uid == currentUser.uid);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoURL;

//  print('signInEmail succeeded: $user');

  return user;
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
  if (snp.data != null) {
    user.delete();
  }
  assert(snp.data == null);
//  var userUpdateInfo = new UserUpdateInfo(); //create user update object
//  userUpdateInfo.displayName = displayName;
//  await user.updateProfile(userUpdateInfo); //update to firebase
//  await user.reload();
//
//  print('displayName= ${userUpdateInfo.displayName}');

  return user;
}

void signOutEmail() {
  _auth.signOut();
  print("User Sign Out");
}

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  // Add the following lines after getting the user
  // Checking if email and name is null
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoURL != null);

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final User currentUser = _auth.currentUser;
  assert(user.uid == currentUser.uid);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoURL;

  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}
