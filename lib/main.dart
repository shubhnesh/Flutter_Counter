import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CounterApp(),
    );
  }
}

class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isPlaying = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _controller.forward(from: 0.0);
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      _controller.forward(from: 0.0);
    });
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _controller.stop();
        _timer?.cancel(); // Cancel the timer if it's active
      } else {
        _controller.repeat(reverse: true);
        _timer = Timer.periodic(Duration(milliseconds: 600), (timer) {
          setState(() {
            _counter++;
          });
        });
      }
      _isPlaying = !_isPlaying;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50], // Background color of the app
      appBar: AppBar(
        title: Text('Flutter Counter App'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_img.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2),
                BlendMode.darken), // Optional: Add a dark overlay to the image
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ScaleTransition(
                scale: _animation,
                child: Text(
                  '$_counter',
                  style: TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: Icon(Icons.add, size: 36),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, shape: CircleBorder(),
                      padding: EdgeInsets.all(20), // Text color
                      shadowColor: Colors.greenAccent, // Shadow color
                      elevation: 5, // Shadow elevation
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _decrementCounter,
                    child: Icon(Icons.remove, size: 36),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red, shape: CircleBorder(),
                      padding: EdgeInsets.all(20), // Text color
                      shadowColor: Colors.redAccent, // Shadow color
                      elevation: 5, // Shadow elevation
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _togglePlayPause,
                    child: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 36,
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue, shape: CircleBorder(),
                      padding: EdgeInsets.all(20), // Text color
                      shadowColor: Colors.blueAccent, // Shadow color
                      elevation: 5, // Shadow elevation
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _resetCounter,
                    child: Icon(Icons.refresh, size: 36),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue, shape: CircleBorder(),
                      padding: EdgeInsets.all(20), // Text color
                      shadowColor: Colors.blueAccent, // Shadow color
                      elevation: 5, // Shadow elevation
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
