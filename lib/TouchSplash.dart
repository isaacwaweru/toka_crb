import 'package:flutter/material.dart';
import 'package:toka_crb/splashOne.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Home(),
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _locations = ['English', 'Swahili']; // Option 2
  String _selectedLocation; // Option 2
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img1.jpg'),
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
                              color: Colors.grey[400],
                              fontSize: 20.0,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 2.0,
                                  color: Colors.grey[400],
                                ),
                                Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 2.0,
                                  color: Colors.grey[400],
                                ),
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff3F73FF).withOpacity(0.4),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(100.0)),
                  ),
                  child: SizedBox(
                    width: 600,
                    height: 380,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 80.0,),
                            Text(
                                'Welcome to Toka-CRB',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                )
                            ),
                            SizedBox(height: 20.0,),
                            Text(
                                'Please choose language',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                )
                            ),
                            SizedBox(height: 15.0,),
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: SizedBox(
                                width: 280.0,
                                height: 50.0,
                                child:
                                DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: Text('Select language'), // Not necessary for Option 1
                                    value: _selectedLocation,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedLocation = newValue;
                                      });
                                    },
                                    iconSize: 35.0,
                                    style: TextStyle(color: Colors.blue),
                                    items: _locations.map((location) {
                                      return DropdownMenuItem(
                                        child: new Text(location),
                                        value: location,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 25.0,),
                            Container(
                              child: SizedBox(
                                width: 300.0,
                                height: 50.0,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Color(0xff3F73FF),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => splashOne()),
                                    );
                                  },
                                  child: Text(
                                      'NEXT',
                                      style: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold)
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 70.0,)
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

