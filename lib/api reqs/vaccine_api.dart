import 'package:covid_tracker_1/models/vaccinedata.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Vaccinecentre {
  List<Centers> vaccinelist = [];
  String _name;
  String _address;
  String _vaccinecount;
  String _vaccinename;
  String _agelimit;
  int x;

  Future<List<Centers>> vaccinecentres(String pin, String date) async {
    Map vaccinedata;

    final inputdata = {'pincode': pin, 'date': date};
    final uri = Uri.https('cdn-api.co-vin.in',
        '/api/v2/appointment/sessions/public/calendarByPin', inputdata);

    http.Response response = await http.get(uri);

    vaccinedata = json.decode(response.body);
    x = vaccinedata['centers'].length;
    print(vaccinedata);
    print(x);
    if (x > 0) {
      for (int index = 0; index < x; index++) {
        _name = vaccinedata['centers'][index]['name'];
        _vaccinecount = vaccinedata['centers'][index]['sessions'][0]
                ['available_capacity']
            .toString();
        _agelimit = vaccinedata['centers'][index]['sessions'][0]
                ['min_age_limit']
            .toString();
        _vaccinename = vaccinedata['centers'][index]['sessions'][0]['vaccine'];
        _address = vaccinedata['centers'][index]['address'];

        vaccinelist.add(Centers(
            address: _address,
            agelimit: _agelimit,
            name: _name,
            vaccinecount: _vaccinecount,
            vaccinename: _vaccinename));
      }
      print(vaccinelist[0].address);
    } else {
      vaccinelist.add(Centers(
          address: 'lol',
          agelimit: 0.toString(),
          name: 'lol',
          vaccinecount: 0.toString(),
          vaccinename: 'lol'));
    }
    return vaccinelist;
  }
}
