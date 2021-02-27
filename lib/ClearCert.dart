import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services/services.dart';
import 'package:toka_crb/CheckProcess.dart';
import 'dart:convert' show json, base64, ascii;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const SERVER_IP = 'http://64.225.3.241:60';
final storage = FlutterSecureStorage();


class ClearCert extends StatefulWidget {
  ClearCert(this.jwt, this.payload);

  factory ClearCert.fromBase64(String jwt) =>
      ClearCert(
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
  _ClearCertState createState() => _ClearCertState();
}

class _ClearCertState extends State<ClearCert> {
  String userName;
  dynamic jwt;
  Future getDataOneA() async {
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
    getDataOneA();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Color(0xff3F73FF).withOpacity(0.5),
            image: DecorationImage(
              image: AssetImage('assets/img6.jpg'),
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
              fit: BoxFit.cover,
            )
        ),
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 70, 0, 0),
                    child: Row(
                      children: [
                        Text(
                            'TOKA CRB',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            )
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                SizedBox(
                  width: 340,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff111112).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 90,),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //ONE
                              Text(
                                  'Thank You '+userName+'',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                              SizedBox(height: 10,),
                              //two
                              Text(
                                  'Toka CRB are working on your white',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  )
                              ),
                              //three
                              Text(
                                  'listing process and you will be able',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  )
                              ),
                              //four
                              Text(
                                  'to download your clearance certificate',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  )
                              ),
                              //five
                              Text(
                                  'in less than 2 weeks. Kindly be',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  )
                              ),
                              //five
                              Text(
                                  'patient as we are working to get you',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  )
                              ),
                              //five
                              Text(
                                  'white-listed from CRB.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  )
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 60,),
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
                                    MaterialPageRoute(builder: (context) => CheckProcess.fromBase64(jwt)
                                    ));
                              },
                              child: Text(
                                  'OK',
                                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 90,),
                        Padding(
                          padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                          child: Container(
                            child: Text(
                                'Powered by Capital White Listing',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 50,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
