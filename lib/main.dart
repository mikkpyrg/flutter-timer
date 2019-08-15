import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer' as con;
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
      home: TimerWidget(),
    );
  }
}

class Track {
  String name;
  Duration track;

  Track(this.name, this.track);
}

class TimerWidget extends StatefulWidget {
  @override
  TimerState createState() => TimerState();
}

class TimerState extends State<TimerWidget> {
  final List<Track> _tracks = [new Track('mari', new Duration(seconds: 15)), 
    new Track('kari', new Duration(seconds: 16)),
    new Track('tari', new Duration(seconds: 17)),
    new Track('pari', new Duration(seconds: 18)),
  ];
  int _selectedTrackIndex = 0;
  Duration _remaining;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _remaining = new Duration(seconds: _tracks[_selectedTrackIndex].track.inSeconds);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _setTime(Timer timer) {
    Duration _timeLeft = _remaining - Duration(milliseconds: 10);
    if (_timeLeft.isNegative) {
      setState(() {
        _remaining = Duration(milliseconds: 0);
      });
      _timer.cancel();
      _timeExceeded();
    } else {
      setState(() {
        _remaining = _timeLeft;
      });
    }
  }

  void _timeExceeded() {
    con.log('beeeeep');
  }

  void _resetTimer() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
    Track _selectedTrack = _tracks[0];
    setState(() {
      _selectedTrackIndex = 0;
      _remaining = new Duration(seconds: _selectedTrack.track.inSeconds);
    });
  }

  void _passTimer() {
    if (_timer == null || !_timer.isActive) {
      _timer = new Timer.periodic(const Duration(milliseconds: 10), _setTime);
    }
    else {
      _selectTrack(_selectedTrackIndex < (_tracks.length - 1) ? _selectedTrackIndex + 1 : 0);
    }
  }

  void _selectTrack(int index) {

    Track _selectedTrack = _tracks[index];
    setState(() {
      _selectedTrackIndex = index;
      _remaining = new Duration(seconds: _selectedTrack.track.inSeconds);
    });
    if (_timer == null || !_timer.isActive) {
      _timer = new Timer.periodic(const Duration(milliseconds: 10), _setTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
	    appBar: AppBar(
	      title: Text('Timer'),
	    ),
	    body: Column(
        children: [
          _mainButton(),
          _trackList()
        ]
      )
	  );
  }

  String get timeString {
    return '${_remaining.inMinutes}:${(_remaining.inSeconds % 60).toString().padLeft(2, '0')}.${((_remaining.inMilliseconds % 1000) / 10).toStringAsFixed(0).padLeft(2, '0')}';
  }

  Widget _mainButton() {
    return Expanded (
      child: Padding(
        padding: EdgeInsets.all(5),
        child: GestureDetector( 
          onTap: () => _passTimer(),
          onLongPress: () => _resetTimer(),
          child: Container (
            color: Colors.green,
            child: Center( 
              child:Column (
                children: [
                  Text(timeString)
                ]
              )
            ),
          ),
        ),
      )
    );
  }

  Widget _trackList() {
    return Container (
    width: double.infinity,
    height: 170,
    child: ListView.builder(
      padding: EdgeInsets.all(5),
      itemCount: _tracks.length,
      itemBuilder: (context, i) {
        Track _trackItem = _tracks[i];
        return Container ( 
          color: _selectedTrackIndex == i ? Colors.lightGreen : Colors.lightBlue,
          child: ListTile(
            title: Text(
              _trackItem.name,
            ),
            leading: Icon(
              _selectedTrackIndex == i ? Icons.timelapse : Icons.timer_off,
              color: _selectedTrackIndex == i ? Colors.green : Colors.yellow,
            ),
            onTap: () => _selectTrack(i),
          ),
        );
      })
    );


  }
}