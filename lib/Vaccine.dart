import 'package:flutter/material.dart';

class Vaccine extends StatefulWidget {
  Vaccine({Key key}) : super(key: key);

  @override
  _VaccineState createState() => _VaccineState();
}

class _VaccineState extends State<Vaccine> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Vaccine'));
  }
}
