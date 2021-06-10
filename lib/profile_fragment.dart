import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';



import 'dart:convert';

import 'package:toast/toast.dart';

class Profile extends StatelessWidget{

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  String name="";
  String phoneNumber="";
  String age="";

  TextEditingController nameController = TextEditingController();
  TextEditingController ageControlller=TextEditingController();
  TextEditingController phoneNumberControlller=TextEditingController();
  @override
  Widget build(BuildContext context) {

    DocumentReference users = FirebaseFirestore.instance.collection('users').doc(firebaseAuth.currentUser!.uid.toString());
    Future<void> addUser() {
      print("++++++++++++"+firebaseAuth.currentUser!.uid);
      Toast.show("Details succesfully updated in the databasse", context,duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      // Call the user's CollectionReference to add a new user
      return users
          .set({
        'full_name': nameController.text, // John Doe
        'phone': phoneNumberControlller.text, // Stokes and Sons
        'age': ageControlller.text // 42
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
    // TODO: implement build
    return MaterialApp(
      home:Scaffold(
        body: Container(

          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image:DecorationImage(
                  image:AssetImage("assets/images/nakul.JPG"),
                  fit: BoxFit.cover
              )
          ),
          child: ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 70.0),
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller:nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 70.0),
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller:phoneNumberControlller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 70.0),
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller:ageControlller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Age',
                  ),
                ),
              ),Container(
                  height: 50,
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 70.0),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('Submit details'),
                    onPressed:addUser,
                  ))
            ],

          ),
        ),
      )
    );
    throw UnimplementedError();
  }

}