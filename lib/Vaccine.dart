import 'package:covid_tracker_1/Search.dart';
import 'package:covid_tracker_1/api%20reqs/vaccine_api.dart';
import 'package:covid_tracker_1/datasource.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

class Vaccine extends StatefulWidget {
  @override
  _VaccineState createState() => _VaccineState();
}

class _VaccineState extends State<Vaccine> {
  final TextEditingController _pinPutController = TextEditingController();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 120,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                color: Colors.blue[50],
                child: Text(
                  DataSource.quote,
                  style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 6),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Text(
                      "Enter Your Pincode",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 45),
                    PinPut(
                      fieldsCount: 6,
                      textStyle:
                          const TextStyle(fontSize: 25.0, color: Colors.white),
                      eachFieldWidth: 40.0,
                      eachFieldHeight: 55.0,
                      controller: _pinPutController,
                      submittedFieldDecoration: pinPutDecoration,
                      selectedFieldDecoration: pinPutDecoration,
                      followingFieldDecoration: pinPutDecoration,
                      pinAnimationType: PinAnimationType.fade,
                      onSubmit: (pin) async {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => Search(
                            pincode: pin,
                          ),
                        ))
                            .then((value) {
                          _pinPutController.clear();
                          final vaccinelist1 = Provider.of<Vaccinecentre>(
                              context,
                              listen: false);
                          setState(() {
                            vaccinelist1.vaccinelist.clear();
                            print("cleared");
                            print(vaccinelist1.vaccinelist);
                          });
                        });
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
