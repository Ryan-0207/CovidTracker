import 'package:covid_tracker_1/models/connectivity.dart';
import 'package:covid_tracker_1/nointernet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:covid_tracker_1/HomePage.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void didChangeDependencies() {
    final connectionProvider = Provider.of<ConnectivityStatus>(context);
    connectionProvider.checkConnectivity();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final connectionProvider = Provider.of<ConnectivityStatus>(context);
    connectionProvider.checkConnectivity();
    if (connectionProvider.connectionStatus == 0) {
      //No Internet
      return NoInternet();
    } else {
      //has internet
      return Homepage();
    }
  }
}
