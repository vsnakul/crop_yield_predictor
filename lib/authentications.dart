import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final gooleSignIn = GoogleSignIn();

// a simple dialog to be visible everytime some error occurs
showErrDialog(BuildContext context, String err) {
  // to hide the keyboard, if it is still p
  FocusScope.of(context).requestFocus(new FocusNode());
  return showDialog(
    builder: (context) => AlertDialog(
      title: Text("Error"),
      content: Text(err),
      actions: <Widget>[
        // ignore: deprecated_member_use
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok"),
        ),
      ],
    ), context: context,
  );
}

// many unhandled google error exist
// will push them soon
// ignore: missing_return
Future<bool> googleSignIn() async{
  GoogleSignInAccount? googleSignInAccount = await gooleSignIn.signIn();

  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    UserCredential result = await auth.signInWithCredential(credential);

    User? user = result.user;
    print(user!.uid);
    // ignore: unused_local_variable
    //final UserCredential googleCredential =
    //await FirebaseAuth.instance.signInWithCredential(credential);

    //User user = await auth.currentUser();
    //print(user.uid);

    return Future.value(true);
  }
  return Future.value(false);
}

// instead of returning true or false
// returning user to directly access UserID
Future<User> signIn(
    String email, String password, BuildContext context) async {
  try {
    UserCredential result =
    await auth.signInWithEmailAndPassword(email: email, password: email);
    User? user = result.user;
    //return Future.value(true);
    return Future.value(user);
  } catch (e) {
    // simply passing error code as a message
    print(e.toString());
    switch (e.toString()) {
      case 'ERROR_INVALID_EMAIL':
        showErrDialog(context, e.toString());
        break;
      case 'ERROR_WRONG_PASSWORD':
        showErrDialog(context, e.toString());
        break;
      case 'ERROR_USER_NOT_FOUND':
        showErrDialog(context, e.toString());
        break;
      case 'ERROR_USER_DISABLED':
        showErrDialog(context, e.toString());
        break;
      case 'ERROR_TOO_MANY_REQUESTS':
        showErrDialog(context, e.toString());
        break;
      case 'ERROR_OPERATION_NOT_ALLOWED':
        showErrDialog(context, e.toString());
        break;
    }
    // since we are not actually continuing after displaying errors
    // the false value will not be returned
    // hence we don't have to check the value returned in from the signin function
    // whenever we call it anywhere
    return Future.value(null);
  }
}

// change to Future<FirebaseUser> for returning a user
Future<User> signUp(
    String email, String password, BuildContext context) async {
  try {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: email);
    User? user = result.user;
    return Future.value(user);
    // return Future.value(true);
  } catch (error) {
    switch (error.toString()) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        showErrDialog(context, "Email Already Exists");
        break;
      case 'ERROR_INVALID_EMAIL':
        showErrDialog(context, "Invalid Email Address");
        break;
      case 'ERROR_WEAK_PASSWORD':
        showErrDialog(context, "Please Choose a stronger password");
        break;
    }
    return Future.value(null);
  }
}


Future<bool> signOutUser() async {
  User? user = auth.currentUser;
  print(user!.providerData[1].providerId);
  if (user.providerData[1].providerId == 'google.com') {
    await gooleSignIn.disconnect();
  }
  await auth.signOut();
  return Future.value(true);
}
