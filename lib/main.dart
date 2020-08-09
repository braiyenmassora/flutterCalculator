import 'package:appsCalculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // make variable to input and output users

  var askUsers = '';
  var ansUsers = '';

  // list index for item in buttons
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(child: Text("SimpleCalculator")),
      ),
      backgroundColor: Colors.deepPurple[50], // main backround
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 0,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                        padding: EdgeInsets.all(20.0),
                        alignment: Alignment.centerRight,
                        child: Text(
                          askUsers,
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        )),
                    Container(
                        padding: EdgeInsets.all(20.0),
                        alignment: Alignment.centerRight,
                        child: Text(
                          ansUsers,
                          style: TextStyle(
                              fontSize: 40.0, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                child: Center(
                    child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButton(
                        // clear button
                        onTapped: () {
                          setState(() {
                            askUsers = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.green,
                        textColor: Colors.white,
                      );
                    } else if (index == 1) {
                      return MyButton(
                        // delete button
                        onTapped: () {
                          setState(() {
                            askUsers =
                                askUsers.substring(0, askUsers.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.redAccent,
                        textColor: Colors.white,
                      );
                    } else if (index == buttons.length - 1) {
                      return MyButton(
                        // equals button
                        onTapped: () {
                          setState(() {
                            pressToEqual();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.deepPurple,
                        textColor: Colors.white,
                      );
                    } else {
                      return MyButton(
                          // rest button
                          onTapped: () {
                            setState(() {
                              // you change use askUsers += buttons[index];
                              askUsers = askUsers + buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: isOperator(buttons[index])
                              ? Colors.deepPurple
                              : Colors.deepPurple[50],
                          textColor: isOperator(buttons[index])
                              ? Colors.white
                              : Colors.deepPurple);
                    }
                  },
                )),
              )),
        ],
      ),
    );
  }

  // this method use to change color in specific  button

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == '-' || x == '+' || x == 'x' || x == '=') {
      return true;
    }
    return false;
  }

  void pressToEqual() {
    String finalResult = askUsers;
    finalResult = finalResult.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalResult);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    ansUsers = eval.toString();
  }
}
