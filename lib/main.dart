import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator UI',
      home: CalculatorApplication(),
    );
  }
}

class CalculatorApplication extends StatefulWidget {
  @override
  _CalculatorApplicationState createState() => _CalculatorApplicationState();
}

class _CalculatorApplicationState extends State<CalculatorApplication> {

  String equation = "0";
  String result = "0";
  String expression = "0";
  double equationFontSize = 30.0;
  double resultFontSize = 35.0;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
      }
      else if(buttonText == "⌫"){
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation= "0";
        }
      }

      else if(buttonText == "="){
        expression = equation;
        expression= expression.replaceAll('×', '*');
        expression= expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }
      }

      else{
        if(equation== "0"){
          equation= buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
        ),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Calculator'),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              print("Navigation icon pressed");
            },
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            children: [

              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
                child: Text(equation, style: TextStyle(fontSize: equationFontSize,
                    color: Colors.white),),
              ),

              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.fromLTRB(15, 40, 15, 15),
                child: Text(result, style: TextStyle(fontSize: resultFontSize, color: Colors.white),),
              ),

              const Expanded(
                child: Divider(),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .75,
                    child: Table(
                      children: [
                        TableRow(
                            children: [
                              buildButton("C", 1, Colors.white),
                              buildButton("⌫", 1, Colors.white),
                              buildButton("X", 1, Colors.white),
                            ]
                        ),

                        TableRow(
                            children: [
                              buildButton("(", 1, Colors.white),
                              buildButton(")", 1, Colors.white),
                              buildButton("%", 1, Colors.white),
                            ]
                        ),

                        TableRow(
                            children: [
                              buildButton("1", 1, Colors.white),
                              buildButton("2", 1, Colors.white),
                              buildButton("3", 1, Colors.white),
                            ]
                        ),

                        TableRow(
                            children: [
                              buildButton("4", 1, Colors.white),
                              buildButton("5", 1, Colors.white),
                              buildButton("6", 1, Colors.white),
                            ]
                        ),

                        TableRow(
                            children: [
                              buildButton("7", 1, Colors.white),
                              buildButton("8", 1, Colors.white),
                              buildButton("9", 1, Colors.white),
                            ]
                        ),

                        TableRow(
                            children: [
                              buildButton("0", 1, Colors.white),
                              buildButton("00", 1, Colors.white),
                              buildButton(".", 1, Colors.white),
                            ]
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Table(
                      children: [
                        TableRow(
                            children: [
                              buildButton("/", 1, Colors.white),
                            ]
                        ),

                        TableRow(
                            children: [
                              buildButton("*", 1, Colors.white),
                            ]
                        ),

                        TableRow(
                            children: [
                              buildButton("-", 1, Colors.white),
                            ]
                        ),

                        TableRow(
                            children: [
                              buildButton("+", 1, Colors.white),
                            ]
                        ),

                        TableRow(
                            children: [
                              buildButton("=", 2, Colors.blueAccent),
                            ]
                        ),
                      ],
                    ),
                  )
                ],
              ),

            ],
          ),
        )
    );
  }
}
