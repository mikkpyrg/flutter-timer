import 'package:flutter/material.dart';
import 'dart:developer' as developer;
// flutter emulators --launch nexus
// flutter run
// r for hot reload
// developer.log('goasdf?');
// to install dependencies
// flutter pub get 

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    	title: 'Say my name',
    	theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Timer(),
    );
  }
}

class Timer extends StatefulWidget {
  @override
  TimerState createState() => TimerState();
}

class TimerState extends State<Timer> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
	    appBar: AppBar(
	      title: Text('Timer'),
	    ),
	    body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('ggaa'),
          Text('wud')

        ]
      )
	  );
  }
}