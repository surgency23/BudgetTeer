import 'package:flutter/material.dart';
import 'package:flutter_numpad_widget/flutter_numpad_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: TransactionSubmission(),
    );
  }
}

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
//   TransactionSubmission createState() => TransactionSubmission();
// }

class TabView extends StatelessWidget {
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
                    child: Text("Reports page"),
                  ),
                ),
                Center(
                  child: ElevatedButton(
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

class TransactionSubmission extends StatelessWidget {
  final controllerForNumPad = NumpadController(format: NumpadFormat.CURRENCY);
  //Text content = new Text(data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Submit your transaction!"),
        ),
        body: Container(
          //padding: EdgeInsets.all(0.0),
          child: Column(
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
              Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: RaisedButton(
                            padding: const EdgeInsets.all(10.0),
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TabView(
                                          text: (controllerForNumPad
                                              .formattedString))));
                            },
                            child: Text("Reports",
                                style: TextStyle(fontSize: 25)))),
                    SizedBox(
                        width: 250,
                        child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TabView(
                                          text: (controllerForNumPad
                                              .formattedString))));
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(10.0),
                            color: Colors.blue,
                            child:
                                Text("Submit", style: TextStyle(fontSize: 25))))
                  ])
            ],
          ),
        ));
  }
}

class ReportsPage extends StatelessWidget {
  final myController = TextEditingController();
  final String text;
  ReportsPage({Key key, this.text}) : super(key: key);
}
