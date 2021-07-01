import 'package:flutter/material.dart';

class NoInternet extends StatefulWidget {
  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NoInternet'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Center(
        child: Column(
          children: [
            Image(image: AssetImage('assets/nointernet.gif')),
            Text(
              'Sorry,No connection found',
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
