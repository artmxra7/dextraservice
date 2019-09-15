import 'dart:async';
import 'dart:convert';
import 'package:dextraservice/global_variable/variable_global.dart';
import 'package:dextraservice/home_user.dart';
import 'package:http/http.dart' as http;

import 'package:dextraservice/pages/LoginAnimation.dart';
import 'package:dextraservice/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';


class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}


/// Component Widget this layout UI
class _loginScreenState extends State<loginScreen>
    with TickerProviderStateMixin {

  //Animation Declaration
  AnimationController sanimationController;
  static const  VariableGlobals = VariableGlobal.URL_BASE;

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  Map<String, double> currentLocation = new Map();
  StreamSubscription<Map<String, double>> locationSubscription;
  Location location = new Location();
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
    print("OKE");

    final responseLogin =
        await http.post("${VariableGlobals}api/auth/login", body: {
      "email": email.text,
      "password": password.text,
      "longitude": currentLocation['longitude'].toString(),
      "latitude": currentLocation['latitude'].toString(),
    }
   
    );
    
//    var status = responseLogin.body.contains("error");
    var dataResponse = json.decode(responseLogin.body);
    var data = dataResponse["data"];
    if (dataResponse["code"] == 0 && data["user_type"] == "user") {
      print("data token : ${dataResponse["code"]}");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Dashboard()));
    }  else {
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
          
    super.initState();

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

  /// Dispose animation controller
  @override
  void dispose() {
    super.dispose();
    sanimationController.dispose();
  }

  /// Playanimation set forward reverse
  Future<Null> _PlayAnimation() async {
    try {
      await sanimationController.forward();
      await sanimationController.reverse();
    } on TickerCanceled {}
  }

  void initPlatformState() async {
    Map<String, double> lokasi;
    try {
      lokasi = await location.getLocation();
      error = "";
    } catch (e) {}
    setState(() {
      currentLocation = lokasi;
    });
  }

  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.width;
    mediaQueryData.size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        /// Set Background image in layout (Click to open code)
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/backgroundgirl.png"),
          fit: BoxFit.cover,
        )),
        child: Container(
          /// Set gradient color in image (Click to open code)
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 0, 0, 0.0),
                Color.fromRGBO(0, 0, 0, 0.3)
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            ),
          ),
          /// Set component layout
          child: ListView(
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        alignment: AlignmentDirectional.topCenter,
                        child: Column(
                          children: <Widget>[
                            /// padding logo
                            Padding(
                                padding: EdgeInsets.only(
                                    top: mediaQueryData.padding.top + 40.0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                  image: AssetImage("images/logo.png"),
                                  height: 70.0,
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.0)),

                             
                              
                              ],
                            ),

                            /// ButtonCustomFacebook
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 30.0)),
                            buttonCustomFacebook(),

                            /// ButtonCustomGoogle
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 7.0)),
                            buttonCustomGoogle(),
                            /// Set Text
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0)),
                            Text(
                              "OR",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 0.2,
                                  fontFamily: 'Sans',
                                  fontSize: 17.0),
                            ),

                            /// TextFromField Email
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0)),
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
                              myController: password,
                              inputType: TextInputType.text,
                            ),

                            /// Button Signup
                            FlatButton(
                                padding: EdgeInsets.only(top: 20.0),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new SignUp()));
                                },
                                child: Text(
                                  "Not Have Acount? Sign Up",
                                  style: TextStyle(
                                      color: Colors.white,
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
                          splashColor: Colors.yellow,
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

  textFromField({this.email, this.icon, this.inputType, this.password, this.myController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: 60.0,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
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
                border: InputBorder.none,
                labelText: email,
                icon: Icon(
                  icon,
                  color: Colors.black38,
                ),
                labelStyle: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Sans',
                    letterSpacing: 0.3,
                    color: Colors.black38,
                    fontWeight: FontWeight.w600)),
            keyboardType: inputType,
          ),
        ),
      ),
    );
  }
}

///buttonCustomFacebook class
class buttonCustomFacebook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        alignment: FractionalOffset.center,
        height: 49.0,
        width: 500.0,
        decoration: BoxDecoration(
          color: Color.fromRGBO(107, 112, 248, 1.0),
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 15.0)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/img/icon_facebook.png",
              height: 25.0,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 7.0)),
            Text(
              "Login With Facebook",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Sans'),
            ),
          ],
        ),
      ),
    );
  }
}

///buttonCustomGoogle class
class buttonCustomGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        alignment: FractionalOffset.center,
        height: 49.0,
        width: 500.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10.0)],
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/img/google.png",
              height: 25.0,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 7.0)),
            Text(
              "Login With Google",
              style: TextStyle(
                  color: Colors.black26,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Sans'),
            )
          ],
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
          "Login",
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 0.2,
              fontFamily: "Sans",
              fontSize: 18.0,
              fontWeight: FontWeight.w800),
        ),
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 15.0)],
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
                colors: <Color>[Color(0xFF121940), Color(0xFF6E48AA)])),
      ),
    );
  }
}
