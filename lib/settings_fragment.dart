

import 'package:crop_yield_predictor/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Settings extends StatelessWidget{

  TextEditingController resetpasswordController=TextEditingController();

  Future<void> _changePassword(BuildContext context) async{
    //Create an instance of the current user.
    FirebaseAuth firebaseAuth =FirebaseAuth.instance;

    //Pass in the password to updatePassword.
    firebaseAuth.currentUser!.updatePassword(resetpasswordController.text).then((_){
      print("Successfully changed password");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      return Future<String>.value("Password reset succesfully");


    }).catchError((error){
      print("Password can't be changed" + error.toString());
      return Future<String>.value("Password reset failed");


      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
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
          child:ListView(
            children: <Widget>[

              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 70),
                padding: EdgeInsets.all(20),
                child: Text('Type in your new password to change your password',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 70),
                padding: EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  controller:resetpasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Reset Password',
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 70),
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('Reset Password details'),
                    onPressed:() async{
                      FirebaseAuth firebaseAuth =FirebaseAuth.instance;

                      //Pass in the password to updatePassword.
                      firebaseAuth.currentUser!.updatePassword(resetpasswordController.text).then((_){
                        print("Successfully changed password");
                        _signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      }).catchError((error){
                        print("Password can't be changed" + error.toString());
                        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
                      });
                    }

                  )),Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 70),
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Log out'),
                      onPressed: ()async{
                      _signOut();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                      },
                      // textColor: Colors.white,
                      // color: Colors.blue,
                      // child: Text('Reset Password details'),
                      // onPressed:() async{
                      //   FirebaseAuth firebaseAuth =FirebaseAuth.instance;
                      //
                      //   //Pass in the password to updatePassword.
                      //   firebaseAuth.currentUser!.updatePassword(resetpasswordController.text).then((_){
                      //     print("Successfully changed password");
                      //     _signOut();
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(builder: (context) => LoginScreen()),
                      //     );
                      //   }).catchError((error){
                      //     print("Password can't be changed" + error.toString());
                      //     //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
                      //   });
                      // }



                  )),


            ],
          )

        ),
      )
    );
    throw UnimplementedError();
  }

}