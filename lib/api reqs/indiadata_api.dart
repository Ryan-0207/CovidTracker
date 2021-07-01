import 'dart:convert';
import 'package:covid_tracker_1/models/indiadata.dart';
import 'package:http/http.dart' as http;

class Indiadata {
  List indiadata;
  int x;

  int deathstoday;
  int recovered;
  int activecases;
  int confirmed;

  List<IndiaModel> indiastats = [];

  getdata() async {
    final uri = Uri.https('api.covid19api.com', '/country/india');
    http.Response response = await http.get(uri);

    indiadata = json.decode(response.body);

    print(indiadata);

    for (int i = 0; i < indiadata.length - 1; i++) {
      confirmed = indiadata[i + 1]['Confirmed'] - indiadata[i]['Confirmed'];
      deathstoday = indiadata[i + 1]['Deaths'] - indiadata[i]['Deaths'];
      recovered = indiadata[i + 1]['Recovered'] - indiadata[i]['Recovered'];
      activecases = indiadata[indiadata.length - 1]['Active'];

      // confirmed = indiadata[i]['Confirmed'];
      // deathstoday = indiadata[i]['Deaths'];
      // recovered = indiadata[i]['Recovered'];
      // activecases = indiadata[i]['Active'];

      indiastats.add(IndiaModel(
          activecases: activecases,
          confirmed: confirmed,
          deathstoday: deathstoday,
          recovered: recovered));
    }
    print(indiastats[0].activecases);
    return indiastats;
  }
}
