import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:services/services.dart';
import 'package:toka_crb/DashTwo.dart';
import 'dart:convert' show json, base64, ascii;
import 'dart:async';

const SERVER_IP = 'http://64.225.3.241:60';
final storage = FlutterSecureStorage();


class DashBoard extends StatefulWidget {
  DashBoard(this.jwt, this.payload);

  factory DashBoard.fromBase64(String jwt) =>
      DashBoard(
          jwt,
          json.decode(
              ascii.decode(
                  base64.decode(base64.normalize(jwt.split(".")[1]))
              )
          )
      );

  final String jwt;
  final Map<String, dynamic> payload;
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String userName;
  dynamic jwt;
  Future getData() async {
    var userDetails = widget.payload;
    var token = widget.jwt;
    Map tokenize = json.decode(token);
    var tokenized = tokenize["token"];
    var idUser = userDetails["userId"];
    var url1 = 'http://64.225.3.241:60/users/${idUser}';
    var resp = await http.get(
        url1,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenized',
        }
    );
    var usersp = resp.body;
    Map dataP = json.decode(usersp);
    var username = dataP["fullName"].split(" ");
    username = username[0].toString();
    var userId = dataP["_id"];
    setState(() {
      userName = username;
      jwt = tokenized;
    });
  }
  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: double.infinity,
              height: 270,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xff3F73FF).withOpacity(1),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0), bottomRight: Radius.circular(50.0)),
                    image: DecorationImage(
                      image: AssetImage('assets/img3.jpg'),
                      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
                      fit: BoxFit.cover,
                    )
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(50, 100, 30, 40),
                  child: SizedBox(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff111112).withOpacity(0.3),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25,),
                            Text(
                                'Hi '+userName+',',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                )
                            ),
                            SizedBox(height: 5,),
                            Text(
                                'Welcome to Toka CRB',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 350,
              height: 400,
              child: Container(
                child: Card(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 80,),
                      Container(
                        child: Column(
                          children: [
                            Text(
                                'Please click the button below to',
                                style: TextStyle(
                                  fontSize: 17.0,
                                )
                            ),
                            Text(
                                'check whether you are listed by',
                                style: TextStyle(
                                  fontSize: 17.0,
                                )
                            ),
                            Text(
                                'any company on CRB',
                                style: TextStyle(
                                  fontSize: 17.0,
                                )
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        child: SizedBox(
                          width: 300.0,
                          height: 50.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Color(0xff3F73FF),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DashBoardTwo.fromBase64(jwt)
                              ));
                            },
                            child: Text(
                                'Check',
                                style: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold)
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 80,),
                      Padding(
                        padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                        child: Container(
                          child: Text('Powered by Capital White Listing'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
