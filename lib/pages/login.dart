import 'dart:async';
import 'dart:convert';
import 'package:dextraservice/global_variable/variable_global.dart';
import 'package:dextraservice/home_user.dart';
import 'package:http/http.dart' as http;

import 'package:dextraservice/pages/LoginAnimation.dart';
import 'package:dextraservice/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

/// Component Widget this layout UI
class _loginScreenState extends State<loginScreen> with TickerProviderStateMixin {

   ProgressDialog pr;
  //Animation Declaration
  AnimationController sanimationController;
  static const VariableGlobals = VariableGlobal.URL_BASE;

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  Map<String, double> currentLocation = new Map();
  StreamSubscription<LocationData> _locationSubscription;
  LocationData _currentLocation;
  var _locationService = new Location();
  String error;

  var tap = 0;

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
    showDialog(context: context, child: alertDialog);
  }

  Future<List> _login() async {

      pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage("Please wait....");
    pr.show();

    final responseLogin =
        await http.post("https://dextra.hattadev.com/public/api/auth/login", body: {
      "email": email.text,
      "password": password.text,
      "longitude": currentLocation['longitude'].toString(),
      "latitude": currentLocation['latitude'].toString(),
    });

    var dataResponse = json.decode(responseLogin.body);
    var data = dataResponse["data"];
    if (dataResponse["code"] == 0 && data["user_type"] == "user") {
      pr.hide();
      print("data token : ${dataResponse["code"]}");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      pr.hide();
      _alertdialog("$data");
    }

    print("data status : ${responseLogin.statusCode}");
    print("data body : ${responseLogin.body}");
    print("data token : ${data["token"]}");
    
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', data["token"]);
    prefs.setString('userType', data["user_type"]);
    prefs.setBool('isLogin', true);
  }

  @override

  /// set state animation controller
  void initState() {
    sanimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tap = 0;
              });
            }
          });


    currentLocation['latitude'] = 0.0;
    currentLocation['longitude'] = 0.0;

    initPlatformState();
   
    
    super.initState();
  }

  /// Dispose animation controller
  @override
  void dispose() {
    sanimationController.dispose();
    super.dispose();
    
  }

  /// Playanimation set forward reverse
  Future<Null> _PlayAnimation() async {
    try {
      await sanimationController.forward();
      await sanimationController.reverse();
    } on TickerCanceled {}
  }

  void initPlatformState() async {
    try {
      _currentLocation = await _locationService.getLocation();
      error = "";
    } catch (e) {}
    setState(() {
     _currentLocation = null;
    });
  }

  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.width;
    mediaQueryData.size.height;
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Container(
          /// Set component layout
          child: ListView(
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: AlignmentDirectional.topCenter,
                        child: Column(
                          children: <Widget>[
                            Container(
                           padding: EdgeInsets.only(
                                  top: mediaQueryData.padding.top + 50.0,
                                  bottom: 0.0),
                              child: Text(
                                'Signin',
                                style: TextStyle(
                                    fontSize: 80.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            /// TextFromField Email
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.0)),
                            textFromField(
                              icon: Icons.email,
                              password: false,
                              email: "Email",
                              myController: email,
                              inputType: TextInputType.emailAddress,
                            ),

                            /// TextFromField Password
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0)),
                            textFromField(
                              icon: Icons.vpn_key,
                              password: true,
                              email: "Password",
                              myController: password,
                              inputType: TextInputType.text,
                            ),

                            /// Button Signup
                            FlatButton(
                                padding: EdgeInsets.only(top: 10.0),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new SignUp()));
                                },
                                child: Text(
                                  "Not Have Acount? Sign Up",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Sans"),
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: mediaQueryData.padding.top + 100.0,
                                  bottom: 0.0),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  /// Set Animaion after user click buttonLogin
                  tap == 0
                      ? InkWell(
                          onTap: () {
                            _login();
                          },
                          child: buttonBlackBottom(),
                        )
                      : new LoginAnimation(
                          animationController: sanimationController.view,
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// textfromfield custom class
class textFromField extends StatelessWidget {
  bool password;
  String email;
  final myController;

  IconData icon;
  TextInputType inputType;

  textFromField(
      {this.email,
      this.icon,
      this.inputType,
      this.password,
      this.myController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: 60.0,
        alignment: AlignmentDirectional.center,
        padding:
            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.transparent,
          ),
          child: TextFormField(
            obscureText: password,
            controller: myController,
            decoration: InputDecoration(
                labelText: email,
                icon: Icon(
                  icon,
                  color: Colors.black38,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green
                  )
                ),
                labelStyle: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Sans',
                    letterSpacing: 0.3,
                    color: Colors.black38,
                    fontWeight: FontWeight.w600)
                  ),
            keyboardType: inputType,
          ),
        ),
      ),
    );
  }
}

///ButtonBlack class
class buttonBlackBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Container(
        height: 55.0,
        width: 600.0,
        child: Text(
          "Signin",
          style: TextStyle(
              color: Colors.black,
              letterSpacing: 0.2,
              fontFamily: "Sans",
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.black,
              style: BorderStyle.solid,
              width: 1.0
            ),
            ),
      ),
    );
  }
}
