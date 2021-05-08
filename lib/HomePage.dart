import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

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
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text("Covid-19 Tracker"),
      // ),
      body: SafeArea(
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
                    image:
                        DecorationImage(image: AssetImage("assets/virus.png")),
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                            Container(
                              width: 210,
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
              SizedBox(height: 15),
              Container(
                  child: Column(children: [
                Text("INDIA",
                    style: GoogleFonts.lato(
                        fontSize: 30, fontWeight: FontWeight.bold)),
                GridView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2),
                  children: <Widget>[
                    StatusPanel(
                      title: 'CONFIRMED',
                      panelColor: Colors.red[100],
                      textColor: Colors.red,
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
                      panelColor: Colors.grey[400],
                      textColor: Colors.grey[900],
                      count: '10',
                    ),
                  ],
                ),
              ]))
            ],
          ),
        ),
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.all(5),
        height: 80,
        width: width / 2,
        color: panelColor,
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
        title,
        style: TextStyle(
      fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
        ),SizedBox(height:10),
        Text(
        count,
        style: TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
        ),
        ),
    );
  }
}
