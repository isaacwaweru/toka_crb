import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toka_crb/splashTwo.dart';
import 'package:toka_crb/LoginPage.dart';

void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  splashOne(),
    )
);

class splashOne extends StatefulWidget {
  @override
  _splashOneState createState() => _splashOneState();
}

class _splashOneState extends State<splashOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Color(0xff3F73FF).withOpacity(0.5),
            image: DecorationImage(
              image: AssetImage('assets/img2.jpg'),
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
                Container(
                  child: SizedBox(
                    width: 600,
                    height: 380,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 5.0,),
                            IconButton(
                                icon: Icon(Icons.check_circle_outline),
                                color: Colors.white,
                                iconSize: 80.0,
                                onPressed: () {},
                              ),
                            Text(
                                'Welcome to Toka CRB',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold
                                )
                            ),
                            SizedBox(height: 5.0,),
                            Text(
                                'APP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.bold
                                )
                            ),
                            SizedBox(height: 10.0,),
                            Center(
                              child: Text(
                                  'Register, check your status and Quickly',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  )
                              ),
                            ),
                            SizedBox(height: 3.0,),
                            Center(
                              child: Text(
                                  'get cleared from CRB even without the ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  )
                              ),
                            ),
                            SizedBox(height: 3.0,),
                            Center(
                              child: Text(
                                  'need to settle your loan.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  )
                              ),
                            ),
                            SizedBox(height: 70.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
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
                                      'SKIP',
                                      style: TextStyle(color: Colors.white, fontSize: 16.0,)
                                  ),
                                ),
                                Text(''),
                                RaisedButton(
                                  elevation: 0,
                                  color: Colors.transparent,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => splashTwo()),
                                    );
                                  },
                                  child: Text(
                                      'NEXT',
                                      style: TextStyle(color: Colors.white, fontSize: 16.0,)
                                  ),
                                ),
                              ],
                            ),
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
