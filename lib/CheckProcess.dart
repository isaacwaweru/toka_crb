import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services/services.dart';
import 'package:toka_crb/ClearCert.dart';
import 'dart:convert' show json, base64, ascii;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const SERVER_IP = 'http://64.225.3.241:60';
final storage = FlutterSecureStorage();

class CheckProcess extends StatefulWidget {
  CheckProcess(this.jwt, this.payload);

  factory CheckProcess.fromBase64(String jwt) =>
      CheckProcess(
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
  _CheckProcessState createState() => _CheckProcessState();
}

class _CheckProcessState extends State<CheckProcess> {
  String userName;
  dynamic jwt;
  Future getDataOneB() async {
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
    getDataOneB();
  }
  void displayDialog(context, title, text) => showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
            title: Text(title),
            content: Text(text)
        ),
  );

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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //ONE
                              Text(
                                  'Congratulation '+userName+'',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold
                                  )
                              ),
                              SizedBox(height: 10,),
                              //two
                              Text(
                                  'Kindly please wait for 2 weeks as we',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  )
                              ),
                              //three
                              Text(
                                  'clear you from CRB. After which you ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  )
                              ),
                              //four
                              Text(
                                  'can come and download you CRB',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  )
                              ),
                              //five
                              Text(
                                  'Clearance Certificate',
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
                              color: Color(0xffA609AB),
                              onPressed: () async {
                                displayDialog(context, "How are you?", "Toka CRB are working on your white listing process kindly be patient");
                              },
                              child: Text(
                                  'DOWNLOAD CERTIFICATE',
                                  style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)
                              ),
                            ),
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
                                    MaterialPageRoute(builder: (context) => ClearCert.fromBase64(jwt)
                                    ));
                              },
                              child: Text(
                                  'CHECK PROGRESS',
                                  style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)
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
