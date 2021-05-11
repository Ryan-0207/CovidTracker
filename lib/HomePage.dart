import 'package:covid_tracker_1/FAQ.dart';
import 'package:covid_tracker_1/Vaccine.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget HomePage() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: 280,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF3383CD),
                        Color(0xFF11249F),
                      ]),
                  image: DecorationImage(image: AssetImage("assets/virus.png")),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 30),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                            child: Text(
                              'Stay Home,\n    Stay Safe',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                          Container(
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                alignment: Alignment.topRight,
                                image: AssetImage("assets/person1.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
                child: Column(children: [
              Text("INDIA",
                  style: GoogleFonts.lato(
                      fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2),
                children: <Widget>[
                  StatusPanel(
                    title: 'CONFIRMED',
                    panelColor: Colors.grey[400],
                    textColor: Colors.grey[900],
                    count: '100',
                  ),
                  StatusPanel(
                    title: 'ACTIVE',
                    panelColor: Colors.blue[100],
                    textColor: Colors.blue[900],
                    count: '100',
                  ),
                  StatusPanel(
                    title: 'RECOVERED',
                    panelColor: Colors.green[100],
                    textColor: Colors.green,
                    count: '100',
                  ),
                  StatusPanel(
                    title: 'DEATHS',
                    panelColor: Colors.red[100],
                    textColor: Colors.red,
                    count: '10',
                  ),
                ],
              ),
            ]))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tab = <Widget>[
      HomePage(),
      Vaccine(),
      FAQ(),
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
