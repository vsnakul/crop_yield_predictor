import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crop_yield_predictor/authentications.dart';
import 'package:crop_yield_predictor/signupScreen.dart';
import 'package:crop_yield_predictor/home_widget.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email="";
  String _password="";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Color gradientStart =
  const Color(0xFFc2ffca); //Change start gradient color here
  Color gradientEnd = const Color(0xFFc2ffca);

  void login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_email);
      print(_password);
      signIn(_email, _password, context).then((value) {
        if (value != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [gradientStart, gradientEnd],
                begin: const FractionalOffset(0.5, 0.0),
                end: const FractionalOffset(0.0, 0.5),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        Transform.translate(
          offset: Offset(0.0, -200),
          child: Container(
            width: 563.0,
            height: 480.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF7aff8c),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x242f595),
                  offset: Offset(-55, -55),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
        ),
        Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(0.0, -5),
                  child: Text(
                    "Login ",
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(50.0),
                                ),
                              ),
                              labelText: "Email"),
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "This Field Is Required"),
                            EmailValidator(errorText: "Invalid Email Address"),
                          ]),
                          onChanged: (val) {
                            _email = val;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(50.0),
                                  ),
                                ),
                                labelText: "Password"),
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Password Is Required"),
                              MinLengthValidator(6,
                                  errorText: "Minimum 6 Characters Required"),
                            ]),
                            onChanged: (val) {
                              _password = val;
                            },
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(50.0),
                            ),
                          ),
                          // ignore: deprecated_member_use
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF7aff8c),
                              onPrimary: Colors.black,
                            ),
                            // passing an additional context parameter to show dialog boxs
                            onPressed: login,
                            child: Text(
                              "Login",
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
                MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: () =>
                      googleSignIn().whenComplete(() async {
                        User? user = auth.currentUser;

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Home()));
                      }),
                  child: Image(
                    image: AssetImage('images/signin.png'),
                    width: 200.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    // send to login screen
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUpScreen()));
                  },
                  child: Text(
                    "Sign Up Here",
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}