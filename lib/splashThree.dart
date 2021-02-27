import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toka_crb/LoginPage.dart';

void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  splashThree(),
    )
);

class splashThree extends StatefulWidget {
  @override
  _splashThreeState createState() => _splashThreeState();
}

class _splashThreeState extends State<splashThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Color(0xff3F73FF).withOpacity(0.5),
            image: DecorationImage(
              image: AssetImage('assets/img7.jpg'),
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
                              icon: Icon(Icons.atm),
                              color: Colors.white,
                              iconSize: 80.0,
                              onPressed: () {},
                            ),
                            Text(
                                'Get more loans/funds',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                            SizedBox(height: 10.0,),
                            Center(
                              child: Text(
                                  'You will be able to borrow again after',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  )
                              ),
                            ),
                            SizedBox(height: 3.0,),
                            Center(
                              child: Text(
                                  'clearance!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  )
                              ),
                            ),
                            SizedBox(height: 90.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                RaisedButton(
                                  elevation: 0,
                                  color: Colors.transparent,
                                  onPressed: () {},
                                  child: Text(
                                      '',
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
                                      MaterialPageRoute(builder: (context) => LoginPage()),
                                    );
                                  },
                                  child: Text(
                                      'START',
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
