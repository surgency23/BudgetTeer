import 'package:flutter/material.dart';
import 'package:flutter_numpad_widget/flutter_numpad_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: TransactionAddingState(),
    );
  }
}

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
//   TransactionAddingState createState() => TransactionAddingState();
// }

class TotalReportingPage extends StatelessWidget {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text('BudgetTeer'),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.attach_money)),
                  Tab(icon: Icon(Icons.settings))
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Go back!'),
                  ),
                ),
                Center(
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Go back!'),
                  ),
                )
              ],
            )));
  }
}

class TransactionAddingState extends StatelessWidget {
  final controllerForNumPad = NumpadController(format: NumpadFormat.CURRENCY);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Submit your transaction!"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(50.0),
              child: NumpadText(
                  controller: controllerForNumPad,
                  style: TextStyle(fontSize: 50))),
          Expanded(
              child: Numpad(
                  buttonColor: Colors.blue,
                  controller: controllerForNumPad,
                  buttonTextSize: 35)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                    padding: const EdgeInsets.all(10.0),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TotalReportingPage()));
                    },
                    child: Text("Reports", style: TextStyle(fontSize: 25)))),
            Expanded(
                child: RaisedButton(
                    onPressed: () {
                      content:
                      Text(controllerForNumPad.formattedString);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TotalReportingPage()));
                    },
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(10.0),
                    color: Colors.blue,
                    child: Text("Submit", style: TextStyle(fontSize: 25))))
          ])
        ],
      ),
    );
  }
}

///the above are the the two buttons that are supposed to be underneath the numpad widget but i want it as a row of 2 buttons. need to figure that out
//  Expanded(
//                   child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[

//                   ]))

/*  child: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.all(40.0),
              child: NumpadText(
                  controller: controllerForNumPad,
                  style: TextStyle(fontSize: 50))),
          Expanded(
              child: Numpad(
                  buttonColor: Colors.blue,
                  controller: controllerForNumPad,
                  buttonTextSize: 35)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Expanded(
              child: RaisedButton(

                  // When the user presses the button, show an alert dialog containing
                  // the text that the user has entered into the text field.
                  onPressed: () {
                    // Retrieve the text the that user has entered by using the
                    // controllerForNumPad.
                    content:
                    Text(controllerForNumPad.formattedString);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TotalReportingPage()));
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(20.0),
                  color: Colors.blue,
                  child: Text("Submit Transaction",
                      style: TextStyle(fontSize: 15))),
            ),
            Expanded(
                child: RaisedButton(
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(20.0),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TotalReportingPage()));
                    },
                    child: Text("Reports", style: TextStyle(fontSize: 25))))
          ])
        ])));
   */
