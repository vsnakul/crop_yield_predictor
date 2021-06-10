import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Predictor extends StatefulWidget{
  @override
  PredictorState createState() => PredictorState();

}

class PredictorState extends State<Predictor>{

  String city="";
  String area="";
  String cropName="";
  String yieldValue="";

  // void displayResults() {
  //   setState(() {
  //
  //   });
  // }

  TextEditingController cityController = TextEditingController();
  TextEditingController areaControlller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body:Container(
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image:DecorationImage(
              image:AssetImage("assets/images/nakul.JPG"),
              fit: BoxFit.cover
            )
          ),
            // padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 70.0),
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller:cityController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'City',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 70.0),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: areaControlller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Area',
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 70.0),
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Predict yield'),
                      onPressed: () async {
                    // ignore: unused_local_variable
                        setState(() {
                          city=cityController.text;
                          area=areaControlller.text;
                        });

                        //resuest to the server
                    await http.post(Uri.parse('https://cropyieldpredictionapp.herokuapp.com/values'),
                    body: json.encode({'city': city, 'area': area}));

                    // ignore: unused_local_variable
                    //response from the server
                    final response = await http
                        .get(Uri.parse('https://cropyieldpredictionapp.herokuapp.com/values?city='+city+'&area='+area));
                    final decoded = json.decode(response.body) as Map<String, dynamic>;
                    setState(() {
                      cropName=decoded['response'];
                      yieldValue=decoded['production'];
                    });

                    print("crop is "+cropName+"and yield value is"+yieldValue);
                    },
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 70.0),
                  height: 50,
                  child: Text(
                    'CROP NAME:$cropName',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 70.0),
                  height: 50,
                  child: Text(
                    'YIELD VALUE:$yieldValue',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                  ),
                )
              ],
            ))

    );
    throw UnimplementedError();
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState


    throw UnimplementedError();
  }
}