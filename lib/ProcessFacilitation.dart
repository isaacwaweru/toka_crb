import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services/services.dart';
import 'package:toka_crb/FinishProcess.dart';
import 'dart:convert' show json, base64, ascii;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const SERVER_IP = 'http://64.225.3.241:60';
final storage = FlutterSecureStorage();

class ProcessFacilitation extends StatefulWidget {
  ProcessFacilitation(this.jwt, this.payload);

  factory ProcessFacilitation.fromBase64(String jwt) =>
      ProcessFacilitation(
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
  _ProcessFacilitationState createState() => _ProcessFacilitationState();
}

class _ProcessFacilitationState extends State<ProcessFacilitation> {
  final TextEditingController _paymentCode = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
            title: Text(title),
            content: Text(text)
        ),
  );

  String userName;
  dynamic jwt;
  dynamic UserId;
  Future getDataOneX() async {
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
      UserId = IdUser;
      userName = username;
      jwt = token;
    });
  }

  Future<int> paymentMethod(dynamic paymentCode, dynamic UserId) async {
    var res = await http.post(
        '$SERVER_IP/code',
        body: {
          "paymentCode": paymentCode,
          "userID": UserId,
        },
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt',
        }
    );
    return res.statusCode;
  }
  @override
  void initState() {
    super.initState();
    getDataOneX();
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
                        SizedBox(height: 30,),
                        Text(
                            'PROCESS FACILITATION',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23.0,
                            )
                        ),
                        SizedBox(height: 50,),
                        //ONE
                        Text(
                            'A facilitation fee of KSH 100 should be paid',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )
                        ),
                        //two
                        Text(
                            'via till number 5537259 and the associated',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )
                        ),
                        //three
                        Text(
                            'MPESA payment transaction code submitted',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )
                        ),
                        //four
                        Text(
                            'below.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )
                        ),
                        //five
                        Text(
                            'The fee is charged depending on the amount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )
                        ),
                        //six
                        Text(
                            'owed by the associated loan lending',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )
                        ),
                        //seven
                        Text(
                            'institution! For more details about this fee',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )
                        ),
                        //eight
                        Text(
                            'please read the Toka CRB App',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )
                        ),
                        //nine
                        Text(
                            'Terms and conditions.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )
                        ),
                        SizedBox(height: 50,),
                        Container(
                          child: SizedBox(
                            width: 300.0,
                            height: 50.0,
                            child: TextField(
                              controller: _paymentCode,
                              style: TextStyle(fontSize: 14, color: Colors.black),
                              decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                hintText: "OJV8Z...",
                                hintStyle: TextStyle(color: Colors.grey.shade800),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
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
                                var paymentCode = _paymentCode.text;


                                if(paymentCode.length < 10)
                                  displayDialog(context, "Invalid name", "Should not be empty!");
                                else{
                                  var res = await paymentMethod(paymentCode, UserId);
                                  if(res == 200)
                                    //                        displayDialog(context, "Success", "The user was created. Log in now.");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => FinishProcess.fromBase64(jwt)
                                      ));
                                  else if(res == 409)
                                    displayDialog(context, "Waah", "What happened");
                                  else {
                                    displayDialog(context, "Error", "An unknown error occurred.");
                                  }
                                }
                              },
                              child: Text(
                                  'SUBMIT',
                                  style: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 80,),
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
