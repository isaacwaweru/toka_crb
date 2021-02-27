import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services/services.dart';
import 'package:toka_crb/ProcessFacilitation.dart';
import 'package:toka_crb/ListingForm.dart';
import 'dart:convert' show json, base64, ascii;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const SERVER_IP = 'http://64.225.3.241:60';
final storage = FlutterSecureStorage();

class DashBoardTwo extends StatefulWidget {
  DashBoardTwo(this.jwt, this.payload);

  factory DashBoardTwo.fromBase64(String jwt) =>
      DashBoardTwo(
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
  _DashBoardTwoState createState() => _DashBoardTwoState();
}

class _DashBoardTwoState extends State<DashBoardTwo> {
  String userName;
  dynamic jwt;
  Future getDataOne() async {
    var userDetail = widget.payload;
    var IdUser = userDetail["userId"];
    print(IdUser);
    var token = widget.jwt;
    print(token);
    var url1 = 'http://64.225.3.241:60/users/${IdUser}';
    var resp = await http.get(
        url1,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }
    );
    var usersp = resp.body;
    Map dataP = json.decode(usersp);
    var username = dataP["fullName"].split(" ");
    username = username[0].toString();
    print(username);
    setState(() {
    });
    setState(() {
      userName = username;
      jwt = token;
    });
  }
  @override
  void initState() {
    super.initState();
    getDataOne();
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
                            SizedBox(height: 40,),
                            Text(
                                'Hi '+userName+',',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                )
                            ),
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
                                'We are sorry that you have already',
                                style: TextStyle(
                                  fontSize: 17.0,
                                )
                            ),
                            Text(
                                'been black listed on CRB',
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
                            color: Color(0xff6BFF3F),
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ListingForm.fromBase64(jwt)
                                  ));
                            },
                            child: Text(
                                'Clear from CRB',
                                style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)
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
