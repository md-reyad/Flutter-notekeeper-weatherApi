import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _setCalculatorState();
  }
}

// ignore: camel_case_types
class _setCalculatorState extends State<Calculator> {
  var _formKey = GlobalKey<FormState>();

  var current_selected_value = "";
  var _currencies = ['Dollar', 'Rupees', 'Pounds'];

  void initState() {
    super.initState();
    current_selected_value = _currencies[0];
  }

  final _minimumMargin = 5.0;
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController poundController = TextEditingController();
  var finalResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Calculate"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minimumMargin * 2),
          child: ListView(
            children: <Widget>[
              getAssetImage(),
              Padding(
                padding: EdgeInsets.only(top: 3, bottom: 10),
                child: TextFormField(
                  controller: principalController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Principal",
                      hintText: "example: 20000",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0)),
                      errorStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.yellow
                      )
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      // ignore: missing_return
                      return "please  enter your principal amount";
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3, bottom: 10),
                child: TextFormField(
                  controller: roiController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Interest",
                      hintText: "Rate of interest",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0))
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      // ignore: missing_return
                      return "please  enter your Rate of interes";
                    }
                  },
                ),

              ),
              Padding(
                padding: EdgeInsets.only(top: 3, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: poundController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Interest",
                            hintText: "Rate of interest",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.0))
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            // ignore: missing_return
                            return "please  enter your Rate of interes";
                          }
                        },
                      ),

                    ),
                    Container(
                      width: 10.0,
                    ),
                    Expanded(
                        child: DropdownButton<String>(
                          items: _currencies.map((location) {
                            return DropdownMenuItem(
                              child: Text(location),
                              value: location,
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            setState(() {
                              this.current_selected_value = newValue;
                            });
                          },
                          value: current_selected_value,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          child: Text(
                            "Calculate",
                            textScaleFactor: 1.3,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState.validate()) {
                                this.finalResult = _calculateTotalReturn();
                              }
                            });
                          },
                        )),
                    Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            "Reset",
                            textScaleFactor: 1.3,
                          ),
                          onPressed: () {
                            setState(() {
                              _resetData();
                            });
                          },
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3, bottom: 10),
                child: Text(finalResult),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: missing_return
  String _calculateTotalReturn() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double pound = double.parse(poundController.text);
    double totalAmount = principal + (principal * roi * pound) / 100;
    String result =
        "After $pound years, your investment will be worth $totalAmount ";
    return result;
  }

  void _resetData() {
    principalController.text = "";
    roiController.text = "";
    poundController.text = "";
    finalResult = "";
    current_selected_value = _currencies[0];
  }
}

Widget getAssetImage() {
  AssetImage assetImage = AssetImage('images/money1.png');
  Image image = Image(image: assetImage, height: 150.0, width: 300.0);
  return Container(
    child: image,
    margin: EdgeInsets.all(5.0 * 5),
  );
}
