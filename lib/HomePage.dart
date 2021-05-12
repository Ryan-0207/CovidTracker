// import 'package:covid_tracker_1/FAQ.dart';
import 'package:covid_tracker_1/Vaccine.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

// ignore: camel_case_types
class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

// ignore: camel_case_types
class _homepageState extends State<homepage> {
  List indiadata;
  int x;

  getdata() async {
    // final uri =
    //     Uri.https('corona.lmao.ninja', '/v3/covid-19/countries/India', input);
    final uri = Uri.https('api.covid19api.com', '/country/india');
    http.Response response = await http.get(uri);
    setState(() {
      indiadata = json.decode(response.body);
      x = indiadata.length - 1;
      print(indiadata);
    });
  }

  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    getdata();
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget homepage() {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text("Covid-19 Tracker"),
      // ),
      body: indiadata == null
          ? Center(
              child: Image(
                image: new AssetImage("assets/loader.gif"),
                height: MediaQuery.of(context).size.width / 2,
                width: MediaQuery.of(context).size.width / 2,
                colorBlendMode: BlendMode.softLight,
                color: Color(0xff0d69ff).withOpacity(1.0),
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xFF3383CD),
                                Color(0xFF11249F),
                              ]),
                          image: DecorationImage(
                              image: AssetImage("assets/virus.png")),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 45),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(30, 30, 30, 30),
                                    child: Text(
                                      'Stay Home,\n    Stay Safe',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 25),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        alignment: Alignment.topRight,
                                        image: AssetImage("assets/person1.png"),
                                      ),
                                    ),
                                  ),

                                  // Image.asset("assets/person.png"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 45),
                    Container(
                        child: Column(children: [
                      Text("INDIA",
                          style: GoogleFonts.lato(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 135),
                      GridView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 2),
                        children: <Widget>[
                          StatusPanel(
                            title: 'NEW CASES',
                            panelColor: Colors.grey[400],
                            textColor: Colors.grey[900],
                            count:
                                '${indiadata[x]['Confirmed'] - indiadata[x - 1]['Confirmed']}',
                          ),
                          StatusPanel(
                            title: 'RECOVERED TODAY',
                            panelColor: Colors.blue[100],
                            textColor: Colors.blue[900],
                            count:
                                '${indiadata[x]['Recovered'] - indiadata[x - 1]['Recovered']}',
                          ),
                          StatusPanel(
                            title: 'ACTIVE',
                            panelColor: Colors.green[100],
                            textColor: Colors.green,
                            count: '${indiadata[x]['Active']}',
                          ),
                          StatusPanel(
                            title: 'DEATHS',
                            panelColor: Colors.red[100],
                            textColor: Colors.red,
                            count:
                                '${indiadata[x]['Deaths'] - indiadata[x - 1]['Deaths']}',
                          ),
                        ],
                      ),
                    ])),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                      child: SingleChildScrollView(
                        child: Center(
                          child: Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 15, 20, 20),
                                child: LineChart(LineChartData(
                                    lineTouchData: LineTouchData(enabled: true),
                                    lineBarsData: [
                                      LineChartBarData(
                                          spots: [
                                            FlSpot(0, 0),
                                            FlSpot(3, 8),
                                            FlSpot(9, 2),
                                            FlSpot(12, 3),
                                          ],
                                          isCurved: true,
                                          colors: [Colors.green],
                                          dotData: FlDotData(
                                            show: false,
                                          )),
                                      LineChartBarData(
                                          spots: [
                                            FlSpot(0, 0),
                                            FlSpot(4, 1),
                                            FlSpot(5, 1),
                                            FlSpot(9, 3),
                                          ],
                                          isCurved: true,
                                          colors: [Colors.red],
                                          dotData: FlDotData(
                                            show: false,
                                          )),
                                      LineChartBarData(
                                          spots: [
                                            FlSpot(0, 0),
                                            FlSpot(3, 0),
                                            FlSpot(6, 1),
                                            FlSpot(8, 3),
                                          ],
                                          isCurved: true,
                                          colors: [Colors.black],
                                          dotData: FlDotData(
                                            show: false,
                                          ))
                                    ])),
                              ),
                              height: 350,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.blueGrey[50])),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tab = <Widget>[
      homepage(),
      Vaccine(),
      //FAQ(),
    ];

    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            tab[_currentIndex],
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.redAccent,
          ),
          BottomNavyBarItem(
              icon: FaIcon(FontAwesomeIcons.syringe),
              title: Text('Vaccine'),
              activeColor: Colors.greenAccent),
          BottomNavyBarItem(
              icon: Icon(Icons.book_rounded),
              title: Text('FAQs'),
              activeColor: Colors.blueAccent),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel(
      {Key key, this.panelColor, this.textColor, this.title, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.black),
        borderRadius: BorderRadius.circular(20),
        color: panelColor,
      ),
      margin: EdgeInsets.all(5),
      height: 80,
      width: width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
          ),
          SizedBox(height: 10),
          Text(
            count,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          )
        ],
      ),
    );
  }
}
