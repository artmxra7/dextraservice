import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dextraservice/global_variable/variable_global.dart';

import 'package:dextraservice/pages/profile.dart';
import 'package:dextraservice/pages/home.dart';
import 'package:dextraservice/pages/history.dart';
import 'package:dextraservice/pages/pesanan.dart';
import 'package:dextraservice/pages/simpan.dart';

class Dashboard extends StatefulWidget {
  bool harga = false;
  bool home = false;

  Dashboard({this.harga, this.home});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _cIndex = 0;
  bool notif = false;
  String data = "5";
  int dataKeranjang;
  bool hom = false;
  var tokenFCM;
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  void _navigateToItemDetail(Map<String, dynamic> message) {
    final String pagechooser = message['status'];
    Navigator.pushNamed(context, pagechooser);
  }

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
      if (_cIndex == 0) {
//        notif = false;
//        data = "0";
        // ambilData();
      } else if (_cIndex == 1) {
//        notif = true;
        // ambilData();
      } else if (_cIndex == 2) {
//        notif = true;
        // ambilData();
      } else if (_cIndex == 3) {
//        notif = true;
      }
//      }
    });
  }

  final _widgetOptions= [
    Home(),
    Simpan(),
    Pesanan(),
    History(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _widgetOptions.elementAt(_cIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _cIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            title: Text('Simpan')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_agenda),
            title: Text('Pemesanan')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text('History')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Akun Saya')
          ),
        ],
        
        onTap: (index) {
          _incrementTab(index);
        },
      ),
    );
  }
}