import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services/services.dart';
import 'package:toka_crb/LoginPage.dart';
import 'package:toka_crb/DashOne.dart ';
import 'package:sms/sms.dart';
import 'dart:convert' show json, base64, ascii;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const SERVER_IP = 'http://64.225.3.241:60';
final storage = FlutterSecureStorage();

void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SignUp(),
    )
);

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool monVal = false;
  bool tuVal = false;
  bool wedVal = false;

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _idNumber = TextEditingController();
  final TextEditingController _county = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirm = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
            title: Text(title),
            content: Text(text)
        ),
  );

  Future<int> attemptSignUp(String fullName, dynamic idNumber, dynamic county, dynamic phoneNumber, dynamic password) async {
    var res = await http.post(
        '$SERVER_IP/register',
        body: {
          "fullName": fullName,
          "idNumber": idNumber,
          "county": county,
          "phoneNumber": phoneNumber,
          "password": password
        }
    );
    return res.statusCode;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Color(0xff3F73FF).withOpacity(0.5),
            image: DecorationImage(
              image: AssetImage('assets/img5.jpg'),
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
              fit: BoxFit.cover,
            )
        ),
        child: Center(
          child: Container(
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 50.0,),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffdbdbdb).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 27,),
                            Text(
                                'TOKA',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                )
                            ),
                            Text(
                                'CRB',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                              child: SizedBox(
                                  width: 300.0,
                                  child: Text(
                                      'Enter details to register',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      )
                                  )
                              )
                          ),
                          SizedBox(height: 10.0,),
                          Container(
                            child: SizedBox(
                              width: 300.0,
                              height: 50.0,
                              child: TextField(
                                controller: _fullName,
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
                                  prefixIcon: Icon(Icons.person),
                                  hintText: "Enter Full Name",
                                  hintStyle: TextStyle(color: Colors.grey.shade800),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Container(
                            child: SizedBox(
                              width: 300.0,
                              height: 50.0,
                              child: TextField(
                                controller: _idNumber,
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
                                  prefixIcon: Icon(Icons.branding_watermark),
                                  hintText: "Enter ID Number",
                                  hintStyle: TextStyle(color: Colors.grey.shade800),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Container(
                            child: SizedBox(
                              width: 300.0,
                              height: 50.0,
                              child: TextField(
                                controller: _county,
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
                                  prefixIcon: Icon(Icons.location_on),
                                  hintText: "Enter Location (County)",
                                  hintStyle: TextStyle(color: Colors.grey.shade800),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Container(
                            child: SizedBox(
                              width: 300.0,
                              height: 50.0,
                              child: TextField(
                                controller: _phoneNumber,
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
                                  prefixIcon: Icon(Icons.phone),
                                  hintText: "Enter Phone",
                                  hintStyle: TextStyle(color: Colors.grey.shade800),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Container(
                            child: SizedBox(
                              width: 300.0,
                              height: 50.0,
                              child: TextField(
                                controller: _password,
                                obscureText: true,
                                style: TextStyle(fontSize: 14, color: Colors.black),
                                decoration: InputDecoration(
                                  // keyboardType: TextInputType.number,
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  prefixIcon: Icon(Icons.vpn_key),
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey.shade800),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Container(
                            child: SizedBox(
                              width: 300.0,
                              height: 50.0,
                              child: TextField(
                                controller: _passwordConfirm,
                                obscureText: true,
                                style: TextStyle(fontSize: 14, color: Colors.black),
                                decoration: InputDecoration(
                                  // keyboardType: TextInputType.number,
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  prefixIcon: Icon(Icons.vpn_key),
                                  hintText: "Confirm Password",
                                  hintStyle: TextStyle(color: Colors.grey.shade800),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0,),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Container(
                              child: Row(
                                children: [
                                  Theme(
                                    child: Checkbox(
                                      value: tuVal,
                                      onChanged: (bool value) {
                                        setState(() {
                                          tuVal = value;
                                        });
                                      },
                                    ),
                                    data: ThemeData(
                                      unselectedWidgetColor: Colors.white, // Your color
                                    ),
                                  ),
                                  Text(
                                      'Agree to Terms and Conditions',
                                      style: TextStyle(color: Colors.white, fontSize: 12.0)
                                  )
                                ],
                              ),
                            ),
                          ),
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
                                  var name = _fullName.text;
                                  var idnumber = _idNumber.text;
                                  var county = _county.text;
                                  var phoneNumber = _phoneNumber.text;
                                  var password = _password.text;
                                  var confirm = _passwordConfirm.text;

                                  if(name.length < 4)
                                    displayDialog(context, "Invalid name", "The name should be at least 4 characters long");
                                  else if(password.length < 4)
                                    displayDialog(context, "Invalid Password", "The password should be at least 4 characters long");
                                  else if(phoneNumber.length < 10)
                                    displayDialog(context, "Invalid Contact", "The contact should be at least 10 characters long");
                                  else if(password.length < 1)
                                    displayDialog(context, "Match Password", "The password should match");
                                  else if(password.length < 4)
                                    displayDialog(context, "Invalid Password", "The password should be at least 4 characters long");
                                  else{
                                    var res = await attemptSignUp(name, idnumber, county, phoneNumber, password);
                                    if(res == 201)
                                      //                        displayDialog(context, "Success", "The user was created. Log in now.");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginPage()),
                                      );
                                    else if(res == 409)
                                      displayDialog(context, "That username is already registered", "Please try to sign up using another username or log in if you already have an account.");
                                    else {
                                      displayDialog(context, "Error", "An unknown error occurred.");
                                    }
                                  }
                                  // _sendSMS(message, recipents);
                                },
                                child: Text(
                                    'Register',
                                    style: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold)
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          RaisedButton(
                            elevation: 0,
                            color: Colors.transparent,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                            child: Text(
                                'Login Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                )
                            ),
                          ),
                          SizedBox(height: 30.0,),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
