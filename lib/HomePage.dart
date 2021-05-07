import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  Map indiadata;
  var uri = Uri.parse(
      'https://corona.lmao.ninja/v3/covid-19/countries/India?strict=true');
  getdata() async {
    http.Response response = await http.get(uri);
    setState(() {
      indiadata = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Covid-19 Tracker"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xFF3383CD),
                          Color(0xFF11249F),
                        ]),
                    image:
                        DecorationImage(image: AssetImage("assets/covid.jpg"))),
              )
            ],
          ),
        ));
  }
}
