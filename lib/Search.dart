import 'package:covid_tracker_1/api%20reqs/vaccine_api.dart';
import 'package:covid_tracker_1/models/connectivity.dart';
import 'package:covid_tracker_1/models/vaccinedata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  final String pincode;
  Search({this.pincode});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoading = false;
  var finalDate = '';
  int z;

  Future<List<Centers>> vaccinedata;
  getCurrentDate() {
    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    setState(() {
      finalDate = formattedDate.toString();
    });
  }

  @override
  void initState() {
    getCurrentDate();
    getvaccine();

    super.initState();
  }

  getvaccine() {
    final vaccinelist1 = Provider.of<Vaccinecentre>(context, listen: false);
    setState(() {
      vaccinedata = vaccinelist1.vaccinecentres(widget.pincode, finalDate);
      z = vaccinelist1.x;
    });
  }

  @override
  Widget build(BuildContext context) {
    //   return vaccinedata != null
    //       ? Scaffold(
    //           backgroundColor: Color(0xFF040F4F),
    //           appBar: AppBar(
    //             backgroundColor: Colors.blue.shade700,
    //             title: Text("Vaccination Centre"),
    //           ),
    //           body: getBody(),
    //         )
    //       : Scaffold(
    //           backgroundColor: Color(0xFF040F4F),
    //           body: Center(
    //             child: Image(
    //               image: new AssetImage("assets/loader.gif"),
    //               height: MediaQuery.of(context).size.width / 2,
    //               width: MediaQuery.of(context).size.width / 2,
    //               colorBlendMode: BlendMode.softLight,
    //               color: Color(0xff0d69ff).withOpacity(1.0),
    //             ),
    //           ),
    //         );
    // }

    // Widget getBody() {
    //   return (z == 0)
    //       ? Card(
    //           color: Color(0xFF040F4F),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Icon(
    //                 CupertinoIcons.multiply_square,
    //                 color: Colors.white,
    //               ),
    //               SizedBox(
    //                 height: 10,
    //               ),
    //               Text('No vaccination centres available in your pincode',
    //                   style: GoogleFonts.lato(
    //                       color: Colors.white,
    //                       fontSize: 17,
    //                       fontWeight: FontWeight.bold)),
    //             ],
    //           ),
    //         )

    return Scaffold(
      backgroundColor: Color(0xFF040F4F),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: Text("Vaccination Centre"),
      ),
      body: getbody(),
    );
  }

  Widget getbody() {
    return Consumer<ConnectivityStatus>(
      builder: (context, connectivity, child) => connectivity
                  .connectionStatus ==
              0
          ? Text('Sorry,no internet,please restart')
          : FutureBuilder(
              future: vaccinedata,
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Centers vaccinecentre2 = snapshot.data[index];

                      String lol = 'lol';
                      int x = 1;
                      if (index == 0) {
                        String lol2 = vaccinecentre2.address;
                        x = lol.compareTo(lol2);
                      }

                      return (x == 0)
                          ? Card(
                              color: Color(0xFF040F4F),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.multiply_square,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      'No vaccination centres available in your pincode',
                                      style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            )
                          : Card(
                              elevation: 1.5,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 45,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.blue[700],
                                          borderRadius:
                                              BorderRadius.circular(60 / 2),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/logo1.jpeg")),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  140,
                                              child: Text(
                                                vaccinecentre2.name,
                                                style: TextStyle(fontSize: 17),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                140,
                                            child: Text(
                                              vaccinecentre2.address,
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Availibilty:' +
                                                vaccinecentre2.vaccinecount,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Eligibilty:' +
                                                vaccinecentre2.agelimit +
                                                '+',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Available Vaccine:' +
                                                vaccinecentre2.vaccinename,
                                            style:
                                                TextStyle(color: Colors.grey),
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
                return Center(
                  child: Image(
                    image: new AssetImage("assets/loader.gif"),
                    height: MediaQuery.of(context).size.width / 2,
                    width: MediaQuery.of(context).size.width / 2,
                    colorBlendMode: BlendMode.softLight,
                    color: Color(0xff0d69ff).withOpacity(1.0),
                  ),
                );
              }),
    );
  }
}
