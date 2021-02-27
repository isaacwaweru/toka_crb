import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services/services.dart';
import 'package:toka_crb/splashTwo.dart';
import 'package:toka_crb/ProcessFacilitation.dart';
import 'dart:convert' show json, base64, ascii;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_sms/flutter_sms.dart';


const SERVER_IP = 'http://64.225.3.241:60';
final storage = FlutterSecureStorage();


class ListingForm extends StatefulWidget {
  ListingForm(this.jwt, this.payload);

  factory ListingForm.fromBase64(String jwt) =>
      ListingForm(
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
  _ListingFormState createState() => _ListingFormState();
}

class _ListingFormState extends State<ListingForm> {
  List<String> _locations = ['500-3000', '3000-10000', '10000-70000', '+70000']; // Option 2
  String _selectedLocation; // Option 2
  String userId;
  dynamic jwt;

  final TextEditingController _institutionName = TextEditingController();
  final TextEditingController _amountOwed = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _YearBorrowed = TextEditingController();
  final TextEditingController _yearToPay = TextEditingController();
  final TextEditingController _reasonNotTo = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
            title: Text(title),
            content: Text(text)
        ),
  );

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  //Logic

  Future getDataOneV() async {
    var userDetail = widget.payload;
    var IdUser = userDetail["userId"];
    print(IdUser);
    var token = widget.jwt;
    print(token);

    setState(() {
    });
    setState(() {
      userId = IdUser;
      jwt = token;
    });
  }

  Future<int> institutionLend(String institutionName, dynamic amount, dynamic phoneNumber, dynamic yearBorrowed, dynamic paymentYear, dynamic unpaymentReasons, dynamic amountRange, dynamic UserId) async {
    var res = await http.post(
        '$SERVER_IP/institution',
        body: {
          "institutionName": institutionName,
          "amount": amount,
          "phoneNumber": phoneNumber,
          "yearBorrowed": yearBorrowed,
          "paymentYear": paymentYear,
          "unpaymentReasons": unpaymentReasons,
          "amountRange": amountRange,
          "UserId": UserId
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
    getDataOneV();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
           child: SizedBox(
             width: 340,
             height: 700,
             child: Card(
               child: ListView(
                 children: [
                   Column(
                     children: [
                       SizedBox(height: 30,),
                       Text('WHITE-LISTING FORM'),
                       SizedBox(height: 5,),
                       Text('Please fill the following form'),
                       Padding(
                         padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                         child: Container(
                           child: Column(
                             children: [
                               TextFormField(
                                 controller: _institutionName,
                                 decoration: InputDecoration(
                                     labelText: 'Name of institution listed you on CRB*'
                                 ),
                               ),
                               TextFormField(
                                 controller: _amountOwed,
                                 decoration: InputDecoration(
                                     labelText: 'Specific Amount owed*'
                                 ),
                               ),
                               TextFormField(
                                 controller: _phoneNumber,
                                 decoration: InputDecoration(
                                     labelText: 'Your phone number*'
                                 ),
                               ),
                               TextFormField(
                                 controller: _YearBorrowed,
                                 decoration: InputDecoration(
                                     labelText: 'Year you borrowed the loan*'
                                 ),
                               ),
                               TextFormField(
                                 controller: _yearToPay,
                                 decoration: InputDecoration(
                                     labelText: 'Year supposed to pay the loan*'
                                 ),
                               ),
                               TextFormField(
                                 controller: _reasonNotTo,
                                 decoration: InputDecoration(
                                     labelText: 'Reason for non-repayment*'
                                 ),
                               ),
                               SizedBox(
                                 width: 300,
                                 height: 50,
                                 child: DropdownButton(
                                   hint: Text('Amount owed*'), // Not necessary for Option 1
                                   value: _selectedLocation,
                                   onChanged: (newValue) {
                                     setState(() {
                                       _selectedLocation = newValue;
                                     });
                                   },
                                   iconSize: 30.0,
                                   style: TextStyle(color: Colors.blue),
                                   items: _locations.map((location) {
                                     return DropdownMenuItem(
                                       child: new Text(location),
                                       value: location,
                                     );
                                   }).toList(),
                                 ),
                               ),
                             ],
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
                               var institutionName = _institutionName.text;
                               var amount = _amountOwed.text;
                               var phoneNumber = _phoneNumber.text;
                               var yearBorrowed = _YearBorrowed.text;
                               var paymentYear = _yearToPay.text;
                               var unpaymentReasons = _reasonNotTo.text;
                               var amountRange = _selectedLocation;
                               var UserId = userId;

                               if(institutionName.length < 1)
                                 displayDialog(context, "Invalid name", "Should not be empty!");
                               else if(phoneNumber.length < 1)
                                 displayDialog(context, "Invalid", "Should not be empty!");
                               else if(phoneNumber.length < 10)
                                 displayDialog(context, "Invalid", "The contact should be at least 10 characters long");
                               else if(UserId.length < 1)
                                 displayDialog(context, "Match Password", "The password should match");
                               else if(amountRange.length < 1)
                                 displayDialog(context, "Invalid", "Should not be empty!");
                               else{
                                 var res = await institutionLend(institutionName, amount, phoneNumber, yearBorrowed, paymentYear, unpaymentReasons, amountRange, UserId);
                                 if(res == 200)

                                   //                        displayDialog(context, "Success", "The user was created. Log in now.");
                                   Navigator.push(
                                       context,
                                       MaterialPageRoute(builder: (context) => ProcessFacilitation.fromBase64(jwt)
                                       ));
                                 else if(res == 409)
                                   displayDialog(context, "Waah", "What happened");
                                 else {
                                   displayDialog(context, "Error", "An unknown error occurred.");
                                 }
                               }
                             },
                             child: Text(
                                 'OK',
                                 style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)
                             ),
                           ),
                         ),
                       ),
                       SizedBox(height: 30,),
                       Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text('Powered by Capital White Listing')
                       ),
                     ],
                   ),
                 ],
               )
             ),
           ),
        ),
      ),
    );
  }
}
