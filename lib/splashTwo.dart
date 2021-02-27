import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toka_crb/splashThree.dart';
import 'package:toka_crb/LoginPage.dart';

void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  splashTwo(),
    )
);

class splashTwo extends StatefulWidget {
  @override
  _splashTwoState createState() => _splashTwoState();
}

class _splashTwoState extends State<splashTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Color(0xff3F73FF).withOpacity(0.5),
            image: DecorationImage(
              image: AssetImage('assets/img8.jpg'),
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
                              icon: Icon(Icons.supervised_user_circle),
                              color: Colors.white,
                              iconSize: 80.0,
                              onPressed: () {},
                            ),
                            Text(
                                'Forget the money sucking ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                            SizedBox(height: 5.0,),
                            Center(
                              child: Text(
                                  'loan lending Apps',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Center(
                              child: Text(
                                  'Forget the money sucking loan lending',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  )
                              ),
                            ),
                            SizedBox(height: 3.0,),
                            Center(
                              child: Text(
                                  'Apps that demand you to repay their',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  )
                              ),
                            ),
                            SizedBox(height: 3.0,),
                            Center(
                              child: Text(
                                  'loans during these hard economic',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  )
                              ),
                            ),
                            Center(
                              child: Text(
                                  'times. Just pay a small fee and we will',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  )
                              ),
                            ),
                            Center(
                              child: Text(
                                  'clear you from CRB listing without even',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  )
                              ),
                            ),
                            Center(
                              child: Text(
                                  'the need to repay your loans.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  )
                              ),
                            ),
                            SizedBox(height: 10.0,),
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
                                      MaterialPageRoute(builder: (context) => splashThree()),
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
