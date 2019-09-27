import 'dart:async';

import 'package:dextraservice/home_user.dart';
import 'package:dextraservice/pages/OnBoarding.dart';
import 'package:dextraservice/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// Run first apps open
void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
    runApp(MyApp());
  });
}

/// Set orienttation
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Set color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));
    return new MaterialApp(
      title: "Dextra App",
      theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          primaryColorLight: Colors.white,
          primaryColorBrightness: Brightness.light),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

/// Component UI
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

/// Component UI
class _SplashScreenState extends State<SplashScreen> {  

  @override
  startTime() async {
    return new Timer(Duration(milliseconds: 4500), onDoneLoading);
  }

  /// Checked Login or Not

  onDoneLoading() async {
    final prefs = await SharedPreferences.getInstance();
    final myBool = prefs.getBool('isLogin');
    final userType = prefs.getString('userType');
    final token = prefs.getString('token');
    final _seen = prefs.getBool('seen');
    
    if (myBool == "" && _seen == "") {
      prefs.setBool('seen', true);
      print("Posisi Anda   $_seen");
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => onBoarding()));
    } else if (myBool == false && _seen == true) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => loginScreen()));
    } else if (myBool == true && userType == "user") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dashboard()));
    } else if (_seen == true) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => loginScreen()));
    } else {
      prefs.setBool('seen', true);
      print("Posisi Anda   $_seen");
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => onBoarding()));
    }
  }

  /// Declare startTime to InitState
  @override
  void initState() {
    super.initState();
    startTime();
  }

  /// Code Create UI Splash Screen
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        /// Set Background image in splash screen layout (Click to open code)
        child: Container(
         
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
                    ),
                    /// Text header "Welcome To" (Click to open code)
                    Text(
                      "Welcome to",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w200,
                        fontFamily: "Sans",
                        fontSize: 19.0,
                      ),
                    ),
                    /// Animation text Treva Shop to choose Login with Hero Animation (Click to open code)
                    Hero(
                      tag: "Dextra",
                      child: Text(
                        "Dextra App",
                        style: TextStyle(
                          fontFamily: 'Sans',
                          fontWeight: FontWeight.w900,
                          fontSize: 35.0,
                          letterSpacing: 0.4,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
