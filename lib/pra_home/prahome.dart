import 'dart:async';
import 'dart:convert';

import 'package:dextraservice/forgot_password.dart';
import 'package:dextraservice/home_partner.dart';
import 'package:dextraservice/home_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:dextraservice/global_variable/variable_global.dart';

class PraHome extends StatefulWidget {
  @override
  _PraHomeState createState() => _PraHomeState();
}

class _PraHomeState extends State<PraHome> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  Map<String, double> currentLocation = new Map();
  StreamSubscription<Map<String, double>> locationSubscription;
  Location location = new Location();
  String error;

  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  void _alertdialog(String str) {
    if (str.isEmpty) return;

    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
        str,
        style: new TextStyle(fontSize: 20.0),
      ),
      actions: <Widget>[
        new RaisedButton(
          color: Colors.purple,
          child: new Text("OK"),
          onPressed: () {
            //ketika button di klik maka akan dismis dialog
            Navigator.pop(context);
          },
        ),
      ],
    );

    // showDialog(context: context, child: alertDialog);
  }
  Future<List> _login() async {
    final responseLogin =
        await http.post("${VariableGlobal.URL_BASE}api/auth/login", body: {
      "email": email.text,
      "password": password.text,
      "longitude": currentLocation['longitude'].toString(),
      "latitude": currentLocation['latitude'].toString(),
    });
//    var status = responseLogin.body.contains("error");
    var dataResponse = json.decode(responseLogin.body);
    var data = dataResponse["data"];
    if (dataResponse["code"] == 0 && data["user_type"] == "user") {
      print("data token : ${dataResponse["code"]}");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Dashboard()));
    } else if (dataResponse["code"] == 0 && data["user_type"] == "partner") {
      print("data token : ${dataResponse["code"]}");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashboardPartner()));
    } else {
      _alertdialog("gagal login");
    }

    print("data status : ${responseLogin.statusCode}");
    print("data body : ${responseLogin.body}");
    print("data token : ${data["token"]}");
    print("data code : ${data["code"]}");
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', data["token"]);
    prefs.setString('userType', data["user_type"]);
    prefs.setBool('isLogin', true);
  }

  bool passwordVisible;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible = false;
    currentLocation['latitude'] = 0.0;
    currentLocation['longitude'] = 0.0;

    initPlatformState();
    locationSubscription =
        location.onLocationChanged().listen((Map<String, double> result) {
      setState(() {
        currentLocation = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var loginForm = new Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          new Padding(padding: new EdgeInsets.only(top: 40.0)),
          new Align(
            child: Text(
              "Email",
              style: new TextStyle(fontWeight: FontWeight.bold),
            ),
            alignment: Alignment.centerLeft,
          ),
          SizedBox(
            height: 50,
            child: new TextField(
              controller: email,
              decoration: new InputDecoration(
                hintText: "Email",
//                    labelText: "Email",
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff01A2F1),
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff01A2F1), width: 2.0),
                    borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
          ),
          new Padding(padding: new EdgeInsets.only(top: 30.0)),
          new Align(
            child: Text(
              "Password",
              style: new TextStyle(fontWeight: FontWeight.bold),
            ),
            alignment: Alignment.centerLeft,
          ),
          SizedBox(
            height: 50,
            child: new TextField(
              controller: password,
              obscureText: !passwordVisible,
              decoration: new InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    }),
                hintText: "Password",
//                    labelText: "Email",
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff01A2F1),
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff01A2F1), width: 2.0),
                    borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
          ),
          new Padding(padding: new EdgeInsets.only(top: 20.0)),
          new Align(
            child: FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ForgotPassword()));
              },
              child: Text(
                "Forgot your password?",
                style: new TextStyle(color: Color(0xff01A2F1), fontSize: 13.0),
              ),
            ),
            alignment: Alignment.center,
          ),
          new Padding(padding: new EdgeInsets.only(top: 20.0)),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Align(
                child: Text(
                  "Sign In",
                  style: new TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.centerRight,
              ),
              new InkWell(
                  onTap: () {
                    _login();
                  },
                  child: new Image.asset(
                    'images/buttton_blue.png',
                    width: 45.0,
                  )),
            ],
          ),
          new Padding(padding: new EdgeInsets.only(top: 100.0)),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Align(
                child: Text(
                  "Don’t have an account?",
                  style: new TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
                alignment: Alignment.bottomCenter,
              ),
              FlatButton(
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Register()));
                },
                child: Text(
                  "Create",
                  style:
                      new TextStyle(color: Color(0xff01A2F1), fontSize: 14.0),
                ),
              ),
            ],
          )
        ],
      ),
    );
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: VariableGlobal.PARRENT_COLOR,
        title: Container(
          width: 200,
          color: VariableGlobal.PARRENT_COLOR,
          padding: new EdgeInsets.fromLTRB(0.0, 15.0, 10, 10),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: new Image.asset(
              'images/new_logo.png',
              width: 170.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      endDrawer: new Drawer(
        child: new ListView(
          children: <Widget>[
//
            new Container(
              height: 170,
              padding: new EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [VariableGlobal.PARRENT_COLOR, Color(0xff01A2F1)]),
              ),
              child: new Image.asset(
                'images/new_logo.png',
                width: 110.0,
                height: 100.0,
              ),
            ),
            new Container(
              padding: new EdgeInsets.all(10.0),
              child: loginForm,
            )
          ],
        ),
      ),

      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 7,
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [VariableGlobal.PARRENT_COLOR, Color(0xff01A2F1)]),
                  ),
//                  child: Image.asset("images/prahome.png", fit: BoxFit.cover,)
                ),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 5,
                    margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          child: new Image.asset(
                            'images/promo.png',
                            width: 250.0,
//                      height: 250.0,
                          ),
                        ),
                        Container(
                          child: new Image.asset(
                            'images/promo.png',
                            width: 250.0,
//                      height: 250.0,
                          ),
                        ),
                        Container(
                          child: new Image.asset(
                            'images/promo.png',
                            width: 250.0,
//                      height: 250.0,
                          ),
                        ),
                        Container(
                          child: new Image.asset(
                            'images/promo.png',
                            width: 250.0,
//                      height: 250.0,
                          ),
                        ),
                        Container(
                          child: new Image.asset(
                            'images/promo.png',
                            width: 250.0,
//                      height: 250.0,
                          ),
                        ),
                        Container(
                          child: new Image.asset(
                            'images/promo.png',
                            width: 250.0,
//                      height: 250.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: new Container(
              margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _alertdialog("sabar");
                    },
                    child: Column(
                      children: <Widget>[
                        new Image.asset(
                          'images/icon_car.png',
                          width: 100.0,
                          height: 50.0,
                        ),
                        new Text("Fleet")
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      new Image.asset(
                        'images/icon_car.png',
                        width: 100.0,
                        height: 50.0,
                      ),
                      new Text("Fleet")
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      new Image.asset(
                        'images/icon_car.png',
                        width: 100.0,
                        height: 50.0,
                      ),
                      new Text("Fleet")
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ), //
    );
  }

  Future initPlatformState() async {
    Map<String, double> lokasi;
    try {
      lokasi = await location.getLocation();
      error = "";
    } catch (e) {}
    setState(() {
      currentLocation = lokasi;
    });
  }
}