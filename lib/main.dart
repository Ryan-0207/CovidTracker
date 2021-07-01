import 'package:covid_tracker_1/api%20reqs/indiadata_api.dart';
import 'package:covid_tracker_1/api%20reqs/vaccine_api.dart';
import 'package:covid_tracker_1/models/connectivity.dart';
import 'package:covid_tracker_1/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => Vaccinecentre()),
      Provider(create: (_) => Indiadata()),
      ChangeNotifierProvider<ConnectivityStatus>(
          create: (_) => ConnectivityStatus())
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Wrapper(),
    ),
  ));
}
