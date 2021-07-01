import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(
    title: "Simple Interest Calculator",
    debugShowCheckedModeBanner: false,
    home: Scaffold(
        appBar: AppBar(
          title: Text("Simple Interest Calculator"),
        ),
        body: myHome()),
    theme: ThemeData(
      //primaryColor:Colors.white24,
      brightness: Brightness.dark,
      accentColorBrightness: Brightness.dark,
      accentColor: Colors.black,
      primaryColor: Colors.indigo,
      focusColor: Colors.indigo,
    ),
  ));
}

class myHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _myHome();
  }
}

class _myHome extends State<myHome> {
  var _formKey=GlobalKey<FormState>();
  String _currencyType = "Rupees";
  List<String> _currencies = <String>["Dollars", "Rupees", "Pounds"];
  TextEditingController principlecontroller=TextEditingController();
  TextEditingController roicontroller=TextEditingController();
  TextEditingController termcontroller=TextEditingController();
  String GetSI()
  {
    if(principlecontroller.text.isEmpty||roicontroller.text.isEmpty||termcontroller.text.isEmpty)
      return "Input correct enter chey ra puka";

    var p=double.parse(principlecontroller.text);
    var r=double.parse(roicontroller.text);
    var t=double.parse(termcontroller.text);
    double SI=p*t*r;
    SI/=100;
    return "$SI";
  }
  String GetI()
  {
    var output=GetSI();
    if(output=="Input correct enter chey ra puka")
      _currencyType="";
    return output+" "+_currencyType;
  }
  void RESET()
  {
    principlecontroller.text="";
    roicontroller.text="";
    termcontroller.text="";
    _currencyType="Rupees";
  }
  Widget build(BuildContext build) {
    return Form(key:_formKey,child:Padding(padding:EdgeInsets.only(left:20,right:20),child:ListView(children: [
      Image(image: AssetImage("images/bank.png"), height: 300, width: 300),
      Container(
          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: TextFormField(
            validator:(String amount)
              {
                if(amount.isEmpty)
                  return "please enter the amount";
                return null;
              },
            keyboardType:TextInputType.number,
            controller:principlecontroller,
              decoration: InputDecoration(
                  labelText: "Principle",
                  labelStyle: Theme.of(context).textTheme.headline6,
                  errorStyle:TextStyle(color:Colors.deepPurple),
                  errorBorder: OutlineInputBorder(borderSide:BorderSide(color:Colors.white)),
                  hintText: "Enter Principle amount",
                  hintStyle: Theme.of(context).textTheme.headline6,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple))))),
      Container(
          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: TextFormField(
            validator:(String amount){
              if(amount.isEmpty)
                return "Please enter the interest";
              return null;
            },
              keyboardType:TextInputType.number,
            controller:roicontroller,
              decoration: InputDecoration(
                  labelText: "Interest",
                  hintText: "Rate of Interest",
                  errorStyle:TextStyle(color:Colors.deepPurple),
                  labelStyle: Theme.of(context).textTheme.headline6,
                  hintStyle: Theme.of(context).textTheme.headline6,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple))))),
      Container(
          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Row(children: [
            Expanded(
                child: TextFormField(
                  validator:(String term)
                    {
                      if(term.isEmpty)
                        return "please enter term";
                      return null;
                    },
                    keyboardType:TextInputType.number,
                  controller:termcontroller,
                    decoration: InputDecoration(
                        labelText: "Term",
                        hintText: "Enter Term",
                        errorStyle:TextStyle(color:Colors.deepPurple),
                        labelStyle: Theme.of(context).textTheme.headline6,
                        hintStyle: Theme.of(context).textTheme.headline6,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        border: OutlineInputBorder()))),
            Container(margin: EdgeInsets.only(left: 5, right: 5)),
            Expanded(
                child: Container(
                    padding: EdgeInsets.only(left: 50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.indigo)),
                    child: DropdownButton<String>(
                      underline: SizedBox(),
                      items: [
                        DropdownMenuItem<String>(
                            value: "Dollars", child: Text("Dollars")),
                        DropdownMenuItem<String>(
                            value: "Rupees", child: Text("Rupees")),
                        DropdownMenuItem<String>(
                            value: "Pounds", child: Text("Pounds"))
                      ],
                      value: _currencyType,
                      onChanged: (String input_value) {
                        return setState(() {
                          this._currencyType = input_value;
                        });
                      },
                    )))
          ])),
      Container(
          margin: EdgeInsets.only(top: 20, left: 5, right: 10),
          child: Row(children: [
            Expanded(
                child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(10,20,30,0.8)
                      ),
                      child: Text("Calculate", textScaleFactor: 1.5),
                      onPressed: () {
                        if(_formKey.currentState.validate())
                        showDialog(
                            context: context,
                            builder: (cntxt) {
                              return AlertDialog(
                                title: Text("SIMPLE INTEREST "),
                                content: Text(GetI()),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(Icons.close))
                                ],
                              );
                            });
                      },
                    ))),
            Container(margin: EdgeInsets.only(left: 2, right: 2)),
            Expanded(
                child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(20, 90, 200, 0.8)),
                      child: Text(
                        "Reset",
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        RESET();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("RESET"),
                                content: Text("SUCCESSFULL"),
                                actions: [
                                  TextButton(
                                    child: Icon(Icons.close),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      },
                    )))
          ]))
    ])));
  }
}
