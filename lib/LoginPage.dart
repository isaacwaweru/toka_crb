import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services/services.dart';
import 'package:toka_crb/SignUp.dart';
import 'package:toka_crb/TermsConditions.dart';
import 'package:toka_crb/DashOne.dart';
import 'dart:convert' show json, base64, ascii;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const SERVER_IP = 'http://64.225.3.241:60';
final storage = FlutterSecureStorage();

void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  LoginPage(),
    )
);

class LoginPage extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
            title: Text(title),
            content: Text(text)
        ),
  );

  Future<String> attemptLogIn(String phoneNumber, String password) async {
    var res = await http.post(
        "$SERVER_IP/login",
        body: {
          "phoneNumber": phoneNumber,
          "password": password
        }
    );
    if(res.statusCode == 200) return res.body;
    print('hakuna kitu');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Color(0xff3F73FF).withOpacity(0.5),
            image: DecorationImage(
              image: AssetImage('assets/img4.jpg'),
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
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffdbdbdb).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40,),
                            Text(
                                'TOKA',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                )
                            ),
                            Text(
                                'CRB',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 100,),
                    Container(
                      child: Column(
                        children: [
                          Container(
                              child: SizedBox(
                                  width: 300.0,
                                  child: Text(
                                      'Enter details to login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      )
                                  )
                              )
                          ),
                          SizedBox(height: 15.0,),
                          Container(
                            child: SizedBox(
                              width: 300.0,
                              height: 50.0,
                              child: TextField(
                                controller: _phoneController,
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
                                  hintText: "Phone number",
                                  hintStyle: TextStyle(color: Colors.grey.shade800),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0,),
                          Container(
                            child: SizedBox(
                              width: 300.0,
                              height: 50.0,
                              child: TextField(
                                controller: _passwordController,
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
                          SizedBox(height: 20.0,),
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
                                  var number = _phoneController.text;
                                  var password = _passwordController.text;
                                  var jwt = await attemptLogIn(number, password);
                                  if(jwt != null) {
                                    storage.write(key: "jwt", value: jwt);
                                    print(jwt);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DashBoard.fromBase64(jwt)
                                        )
                                    );
                                  } else {
                                    displayDialog(context, "An Error Occurred", "No account was found matching that username and password");
                                  }
                                },
                                child: Text(
                                    'Login',
                                    style: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold)
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0,),
                          RaisedButton(
                            elevation: 0,
                            color: Colors.transparent,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TermsConditions()),
                              );
                            },
                            child: Text(
                                'Register Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                )
                            ),
                          ),
                          SizedBox(height: 50.0,),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

