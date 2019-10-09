import 'dart:async';
import 'dart:convert';

import 'package:dextraservice/Components/loading.dart';
import 'package:dextraservice/home_user.dart';
import 'package:dextraservice/pages/Profile.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FindMekanik extends StatefulWidget {
  final String jobscode, brand, model, serialNumber, permasalahan, lokasi, latitude, longtitude, detailokasi;
  FindMekanik({this.jobscode, this.brand, this.model, this.serialNumber, this.permasalahan, this.lokasi, this.latitude, this.longtitude, this.detailokasi});
  @override
  _FindMekanikState createState() => _FindMekanikState();
}

class _FindMekanikState extends State<FindMekanik> {
  Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            _verification();
            
            dispose();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
              (Route<dynamic> route) => false,
            );
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<List> _verification() async {
   
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${token}',
    };

    final responseLogin = await http.post(
        "https://dextra.hattadev.com/public/api/user/job/create",
        body: {
          "job_category_id": widget.jobscode,
          "brand": widget.brand,
          "model": widget.model,
          "serialNumber": widget.serialNumber,
          "description": widget.permasalahan,
          "location_description": widget.detailokasi,
          "location_name": widget.lokasi,
          "latitude" : widget.latitude,
          "longtitude": widget.longtitude
        },
        headers: requestHeaders);
    var dataResponse = json.decode(responseLogin.body);
    print("REGISTER FINAL " + dataResponse.toString());
    print("REGISTER JSON " + responseLogin.toString());

    if (dataResponse["code"] == 0) {
      print(dataResponse);   
      
      print("data token : ${dataResponse["code"]}");
      
    } else {
      print("GAGAL : ${dataResponse["code"]}");
    }
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content:
                new Text('Apakah anda ingin membatalkan Pencarian Mekanik?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () {
                  dispose();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Dashboard()),
                      (Route<dynamic> route) => false);
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.width;
    mediaQueryData.size.height;

    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Mencari Mekanik",
                        style: TextStyle(fontSize: 25.0),
                      ),
                      Text("$_start")
                    ],
                  ),
                ),
                LoadingBuilder(),
              ],
            )),
      ),
    );
  }
}
