import 'package:covid_tracker_1/FAQ.dart';
import 'package:covid_tracker_1/MyClipper.dart';
import 'package:covid_tracker_1/StatusPanel.dart';
import 'package:covid_tracker_1/Vaccine.dart';
import 'package:covid_tracker_1/api%20reqs/indiadata_api.dart';

import 'package:covid_tracker_1/models/indiadata.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List indiadata2 = [];
  int y;
  int _currentIndex = 0;
  IndiaModel finalstats;
  PageController _pageController;
   List<FlSpot> listData2 = [];
  List<FlSpot> listData = [];
  List<FlSpot> listData1 = [];

  List<FlSpot> gatherRecovery() {
    if (listData.isEmpty) {
      for (int i = 100; i < indiadata2.length - 1; i++) {
        IndiaModel indiastats = indiadata2[i];
        listData.add(FlSpot(i * 1.0, indiastats.recovered * 1.0));
      }
    }
    return listData;
  }

  List<FlSpot> gatherDeaths() {
    if (listData1.isEmpty) {
      for (int i = 100; i < indiadata2.length - 1; i++) {
        IndiaModel indiastat2 = indiadata2[i];
         listData1.add(new FlSpot(i * 1.0, indiastat2.deathstoday * 1.0));
      }
    }
    return listData1;
  }

   List<FlSpot> gatherConfirmed() {
    // if (listData2.isEmpty) {
    // print("hi");
    for (int i = 100; i < indiadata2.length - 1; i++) {
      IndiaModel indiastat3 = indiadata2[i];
      listData2.add(new FlSpot(i * 1.0, indiastat3.confirmed * 1.0));
    }

    return listData2;
  }

  @override
  void initState() {
    getdata2();

    super.initState();
    _pageController = PageController();
  }

  getdata2() async {
    final indiastats1 = Provider.of<Indiadata>(context, listen: false);

    indiadata2 = await indiastats1.getdata();
    print('Indiadata2 is:${indiadata2[4].activecases}');
    y = indiadata2.length;

    if (indiadata2 != null) {
      setState(() {
        finalstats = indiadata2[y - 1];
      });
    }
    print('y is $y');
    print(finalstats.activecases);
    print(finalstats.confirmed);
    print(finalstats.recovered);
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tab = <Widget>[
      homepage(),
      Vaccine(),
      FAQ(),
    ];

    return Scaffold(
      body: Center(
        child: SizedBox.expand(
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

  // Widget futurebuilder() {
  //   return FutureBuilder(
  //     future: indiadata,
  //     builder: (context,snapshot){

  //     },
  //   );
  // }

  Widget homepage() {
    return finalstats == null
        ? Scaffold(
            backgroundColor: Color(0xFF040F4F),
            body: Center(
              child: Image(
                image: new AssetImage("assets/loader.gif"),
                height: MediaQuery.of(context).size.width / 2,
                width: MediaQuery.of(context).size.width / 2,
                colorBlendMode: BlendMode.softLight,
                color: Color(0xff0d69ff).withOpacity(1.0),
              ),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3.5,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xFF3383CD),
                              Color(0xFF11249F),
                            ],
                          ),
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 45),
                    Container(
                      child: Column(
                        children: [
                          Text("INDIA",
                              style: GoogleFonts.lato(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 135),
                          GridView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 2),
                            children: <Widget>[
                              StatusPanel(
                                title: 'NEW CASES',
                                panelColor: Colors.grey[400],
                                textColor: Colors.grey[900],
                                count: '${finalstats.confirmed.toString()}',
                              ),
                              StatusPanel(
                                title: 'RECOVERED TODAY',
                                panelColor: Colors.blue[100],
                                textColor: Colors.blue[900],
                                count: '${finalstats.recovered.toString()}',
                              ),
                              StatusPanel(
                                title: 'ACTIVE',
                                panelColor: Colors.green[100],
                                textColor: Colors.green,
                                count: '${finalstats.activecases.toString()}',
                              ),
                              StatusPanel(
                                title: 'DEATHS',
                                panelColor: Colors.red[100],
                                textColor: Colors.red,
                                count: '${finalstats.deathstoday.toString()}',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 45),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 15, 20, 20),
                                    child: LineChart(
                                      LineChartData(
                                        minX: 100,
                                        minY: 0,
                                        gridData: FlGridData(show: false),
                                        titlesData: FlTitlesData(
                                          show: false,
                                          leftTitles: SideTitles(
                                            showTitles: true,
                                          ),
                                        ),
                                        lineTouchData:
                                            LineTouchData(enabled: true),
                                        lineBarsData: [
                                          LineChartBarData(
                                              spots: gatherRecovery(),
                                              isCurved: true,
                                              colors: [Colors.green],
                                              dotData: FlDotData(
                                                show: false,
                                              )),
                                          LineChartBarData(
                                              spots: gatherDeaths(),
                                              isCurved: true,
                                              colors: [Colors.red],
                                              dotData: FlDotData(
                                                show: false,
                                              )),
                                          LineChartBarData(
                                              spots: gatherConfirmed(),
                                              isCurved: true,
                                              colors: [Colors.black],
                                              dotData: FlDotData(
                                                show: false,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                  height: 400,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.blue[100])),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(17, 10, 0, 0),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Recovered - Green',
                                          style: GoogleFonts.lato(
                                              color: Colors.green,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 5),
                                      Text('Deaths - Red',
                                          style: GoogleFonts.lato(
                                              color: Colors.red,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 5),
                                      Text('Confirmed - Black',
                                          style: GoogleFonts.lato(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
