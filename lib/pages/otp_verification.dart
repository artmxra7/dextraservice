import 'package:dextraservice/helper/dialog.dart';
import 'package:dextraservice/pages/login.dart';
import 'package:dextraservice/pages/signup.dart';
import 'package:dextraservice/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:progress_dialog/progress_dialog.dart';

class otpverification extends StatefulWidget {
  final String name, hp, email, password, passwordCon, requestId;

  otpverification(
      {this.name,
      this.hp,
      this.email,
      this.password,
      this.passwordCon,
      this.requestId});
  @override
  _otpverificationState createState() => _otpverificationState();
}

class _otpverificationState extends State<otpverification> {
  ProgressDialog pr;

  Future<List> _verification(String code) async {
    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage("Please wait....");
    pr.show();
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    final responseLogin = await http.post(
        "https://dextra.hattadev.com/public/api/user/register/finish",
        body: {
          "request_id": widget.requestId,
          "code": code,
          "name": widget.name,
          "users_hp": widget.hp,
          "email": widget.email,
          "password": widget.password,
        },
        headers: requestHeaders);
    var dataResponse = json.decode(responseLogin.body);
    print("REGISTER FINAL " + dataResponse.toString());
    print("REGISTER JSON " + responseLogin.toString());

    if (dataResponse["code"] == 0) {
      print(dataResponse);
      pr.hide();
      alertDialog(context, "sukses daftar");
      print("data token : ${dataResponse["code"]}");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => loginScreen()));
    } else {
      pr.hide();
      alertDialog(context, dataResponse["message"]);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("nama ${widget.name}");
    print("hp ${widget.hp}");
    print("email${widget.email}");
    print("password${widget.password}");
    print("pascon${widget.passwordCon}");
  }

  TextEditingController controller = TextEditingController();
  String thisText = "";
  int pinLength = 4;

  bool hasError = false;
  String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: whiteColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: blackColor,
          ),
          onPressed: () => Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => SignUp())),
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                  child: Text(
                    'Verification Has Been Sent to Your Email',
                    style: heading35Black,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text('Enter your OTP code here'),
                ),
                Container(
                  child: PinCodeTextField(
                    autofocus: true,
                    controller: controller,
                    hideCharacter: false,
                    highlight: true,
                    highlightColor: secondary,
                    defaultBorderColor: blackColor,
                    hasTextBorderColor: primaryColor,
                    maxLength: pinLength,
                    hasError: hasError,
                    maskCharacter: "*",
                    onTextChanged: (text) {
                      setState(() {
                        hasError = false;
                      });
                    },
                    onDone: (text) {
                      print("DONE $text");
                    },
                    pinCodeTextFieldLayoutType:
                        PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
                    wrapAlignment: WrapAlignment.start,
                    pinBoxDecoration:
                        ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
                    pinTextStyle: heading35Black,
                    pinTextAnimatedSwitcherTransition:
                        ProvidedPinBoxTextAnimation.scalingTransition,
                    pinTextAnimatedSwitcherDuration:
                        Duration(milliseconds: 300),
                  ),
                ),
                new Container(
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new InkWell(
                          onTap: () => Navigator.pushNamed(context, '/login2'),
                          child: new Text(
                            "Didn't get a code? Resend a new Code",
                            style: textStyleActive,
                          ),
                        ),
                      ],
                    )),
                InkWell(
                  onTap: () {
                    _verification(controller.text);
                  },
                  child: buttonBlackBottom(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class buttonBlackBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Container(
        height: 55.0,
        width: 600.0,
        child: Text(
          "Verification",
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
              color: Colors.black, style: BorderStyle.solid, width: 1.0),
        ),
      ),
    );
  }
}
