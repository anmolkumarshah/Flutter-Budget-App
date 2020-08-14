import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flex Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flex Example"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            color: Colors.red,
            child: Text("Left Box"),
            height: 100,
          ),

          Flexible(
              fit: FlexFit.tight,
              child: Container(
              height: 100,
              color: Colors.orange,
              child: Text('Middle Box'),
            ),
          ),

          Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Container(
              child: Text(
                'Right Box',
                style: TextStyle(
                  color: Colors.white,
                ), 
              ),
              color: Colors.purple,
              height: 300,
            ),
          ),


        ],
      ),
    );
  }
}