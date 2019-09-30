import 'dart:async';

import 'package:dextraservice/Model/response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:dextraservice/helper/dialog.dart';
import 'package:dextraservice/pages/LoginAnimation.dart';
import 'package:dextraservice/pages/login.dart';
import 'package:dextraservice/pages/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //Animation Declaration
  AnimationController sanimationController;
  AnimationController animationControllerScreen;
  Animation animationScreen;
  var tap = 0;
      

  ProgressDialog pr;

TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController passwordCon = new TextEditingController();
  TextEditingController hp = new TextEditingController();

  String verifikasi = "";
  String requestId = "";
  
  Future<Default> _signUp() async {

    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage("Please wait....");
    pr.show();
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    

    final responseLogin =
        await http.post("https://dextra.hattadev.com/public/api/user/register/step1", body: {
      "email": email.text,
      "password": password.text,
      "password_confirmation": passwordCon.text,
      "users_hp": hp.text,
    },
    headers: requestHeaders);

    var response = json.decode(responseLogin.body);
    var data = response["data"];

  
    print("PR status  ${pr.isShowing()}");
    if (pr.isShowing()) pr.hide();
    print("PR status  ${pr.isShowing()}");
    print("REGISTER 1 JSON " + response.toString());

    if (response["code"] == 0) {
      requestId = response["data"]["request_id"];
      print("sukses daftar");
      print("REQUEST ID " + requestId);

    if (requestId.isEmpty) {
        alertDialog(context, "request id ga dapet");
      } else {
        Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new otpverification(
            name: name.text,
                hp: hp.text,
                email: email.text,
                password: password.text,
                passwordCon: passwordCon.text,
                requestId: requestId,
              ),
        ));
      }
    } else {
      alertDialog(context, "gagal Daftar");
    }

   
  }


  /// Playanimation set forward reverse
  Future<Null> _PlayAnimation() async {
    try {
      await sanimationController.forward();
      await sanimationController.reverse();
    } on TickerCanceled {}
  }

  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.height;
    mediaQueryData.size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
            child: Container(
              /// Set component layout
              child: ListView(
                padding: EdgeInsets.all(0.0),
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
                                Container(
                                  padding: EdgeInsets.only(
                                      top: mediaQueryData.padding.top + 50.0,
                                      bottom: 0.0),
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: 80.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.0)),

                                        textFromField(
                                  myController: name,
                                  icon: Icons.account_circle,
                                  password: false,
                                  email: "Name",
                                  inputType: TextInputType.emailAddress,
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0)),

                                /// TextFromField Email
                                textFromField(
                                  myController: email,
                                  icon: Icons.email,
                                  password: false,
                                  email: "Email",
                                  inputType: TextInputType.emailAddress,
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0)),

                                /// TextFromField Password
                                textFromField(
                                  myController: password,
                                  icon: Icons.vpn_key,
                                  password: true,
                                  email: "Password",
                                  inputType: TextInputType.text,
                                ),

                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0)),

                                textFromField(
                                  myController: passwordCon,
                                  icon: Icons.vpn_key,
                                  password: true,
                                  email: "Confirm Password",
                                  inputType: TextInputType.text,
                                ),

                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0)),

                                textFromField(
                                  myController: hp,
                                  icon: Icons.phone_android,
                                  password: false,
                                  email: "Phone Number",
                                  inputType: TextInputType.number,
                                ),

                                /// Button Login
                                FlatButton(
                                    padding: EdgeInsets.only(top: 20.0),
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new loginScreen()));
                                    },
                                    child: Text(
                                      " Have Acount? Sign In",
                                      style: TextStyle(
                                          color: Colors.black87,
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
                                _signUp();
                              },
                              child: ButtonBlackBottom(),
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
        ],
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

///ButtonBlack class
class ButtonBlackBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Container(
        height: 55.0,
        width: 600.0,
        child: Text(
          "Sign Up",
          style: TextStyle(
              color: Colors.black,
              letterSpacing: 0.2,
              fontFamily: "Sans",
              fontSize: 18.0,
              fontWeight: FontWeight.w800),
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
