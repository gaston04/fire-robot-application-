import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ManualPage extends StatefulWidget {
  @override
  _ManualPageState createState() => _ManualPageState();
}

class _ManualPageState extends State<ManualPage> {
  bool _isPumpOn = false;
  String _robotDirection = '';
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  void updateDatabase(String key, dynamic value) {
    _database.child(key).set(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manual Control'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Video stream container
              Container(
                width: 300, // Adjust the width as needed
                height: 200, // Adjust the height as needed
                color: Colors.black, // Placeholder color
                // Add your video stream widget here
              ),
              SizedBox(
                  height: 20), // Add spacing between video stream and buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _robotDirection = 'forward';
                          });
                        },
                        child: Icon(Icons.arrow_upward),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _robotDirection = 'left';
                          });
                        },
                        child: Icon(Icons.arrow_left),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _robotDirection = 'right';
                          });
                        },
                        child: Icon(Icons.arrow_right),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _robotDirection = 'backward';
                          });
                        },
                        child: Icon(Icons.arrow_downward),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Robot direction: $_robotDirection',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isPumpOn = !_isPumpOn;
                    updateDatabase('pumpStatus', _isPumpOn);
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: _isPumpOn ? Colors.green : Colors.red,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.power_settings_new),
                    SizedBox(width: 10),
                    Text('Pump'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
