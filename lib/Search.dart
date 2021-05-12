import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String pincode;
  Search({this.pincode});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoading = false;
  var finalDate = '';
  getCurrentDate() {
    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    setState(() {
      finalDate = formattedDate.toString();
    });
  }

  Map vaccinedata;
  getdata(String pin, String date) async {
    final inputdata = {'pincode': pin, 'date': date};
    final uri = Uri.https('cdn-api.co-vin.in',
        '/api/v2/appointment/sessions/public/calendarByPin', inputdata);

    http.Response response = await http.get(uri);

    setState(() {
      vaccinedata = json.decode(response.body);
    });
  }

  @override
  void initState() {
    getCurrentDate();
    getdata(widget.pincode, finalDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vaccination Centre"),
      ),
      body: vaccinedata == null
          ? Center(
              child: Image(
                image: new AssetImage("assets/loader.gif"),
                height: MediaQuery.of(context).size.width / 2,
                width: MediaQuery.of(context).size.width / 2,
                colorBlendMode: BlendMode.softLight,
                color: Color(0xff0d69ff).withOpacity(1.0),
              ),
            )
          : getBody(),
    );
  }

  Widget getBody() {
    return ListView.builder(
      itemCount: vaccinedata['centers'].length,
      itemBuilder: (context, index) {
        var centername = vaccinedata['centers'][index]['name'];
        var vaccinecount =
            vaccinedata['centers'][index]['sessions'][0]['available_capacity'];
        var agelimit =
            vaccinedata['centers'][index]['sessions'][0]['min_age_limit'];
        var vaccinename =
            vaccinedata['centers'][index]['sessions'][0]['vaccine'];
        var address = vaccinedata['centers'][index]['address'];

        return Card(
          elevation: 1.5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Row(
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(60 / 2),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/logo.jpg")),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 140,
                          child: Text(
                            '$centername',
                            style: TextStyle(fontSize: 17),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 140,
                        child: Text(
                          '$address',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Availibilty:$vaccinecount',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Eligibilty:$agelimit +',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Available Vaccine: $vaccinename',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
