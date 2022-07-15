import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'calculator',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var itemlist = ['Rupee', 'Dollar', 'Pound', 'Other'];
  var selected = 'Rupee';

  var formkey = GlobalKey<FormState>();

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayresult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('calculator'),
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                  child: Icon(
                Icons.money_off,
                color: Colors.amberAccent,
                size: 150,
              )),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'principal',
                    hintText: 'inter principal amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    )),
                keyboardType: TextInputType.number,
                controller: principalController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please inter';
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Rate of interest',
                    hintText: 'inter rate of interest',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    )),
                keyboardType: TextInputType.number,
                controller: roiController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please inter';
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Duration',
                            hintText: 'inter duration in year',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )),
                        keyboardType: TextInputType.number,
                        controller: termController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please inter';
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                      child: DropdownButton(
                    items: itemlist
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (newselected) {
                      selection(newselected);
                    },
                    value: selected,
                  ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        if (formkey.currentState!.validate()) {
                          displayresult = calculatTotalAmount();
                        }
                      });
                    },
                    child: Text(
                      'result',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w700),
                    ),
                  )),
                  SizedBox(width: 8.0),
                  Expanded(
                      child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        reset();
                      });
                    },
                    child: Text(
                      'reset',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w700),
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                displayresult,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void selection(newvalue) {
    setState(() {
      selected = newvalue;
    });
  }

  String calculatTotalAmount() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalamount = principal + (principal * roi * term) / 100;
    String result =
        'after $term years your investment will be worth $totalamount in $selected';
    return result;
  }

  void reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayresult = '';
    selected = itemlist[0];
  }
}
