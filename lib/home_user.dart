import 'package:flutter/material.dart';

import 'package:dextraservice/pages/profile.dart';
import 'package:dextraservice/pages/home.dart';
import 'package:dextraservice/pages/pesanan.dart';
import 'package:dextraservice/pages/simpan.dart';

class Dashboard extends StatefulWidget {
 
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _cIndex = 0;

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
            icon: Icon(Icons.assignment),
            title: Text('Quotes')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Cart')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Account')
          ),
        ],
        
        onTap: (index) {
          _incrementTab(index);
        },
      ),
    );
  }
}