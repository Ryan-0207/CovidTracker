import 'package:flutter/material.dart';
<<<<<<< HEAD

class FAQ extends StatefulWidget {
  FAQ({Key key}) : super(key: key);

  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("FAQS"));
=======
import 'package:covid_tracker_1/datasource.dart';

class FAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: Text('FAQs'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: DataSource.questionAnswers.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                backgroundColor: Colors.blue[50],
                title: Text(
                  DataSource.questionAnswers[index]['question'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(DataSource.questionAnswers[index]['answer']),
                  )
                ],
              );
            }),
      ),
    );
>>>>>>> main
  }
}
