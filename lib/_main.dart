
import 'package:dextraservice/home_user.dart';
import 'package:dextraservice/pages/OnBoarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dextraservice/pages/profile.dart';
import 'package:dextraservice/pages/home.dart';
import 'package:dextraservice/pages/history.dart';
import 'package:dextraservice/pages/pesanan.dart';
import 'package:dextraservice/pages/simpan.dart';

import 'package:dextraservice/global_variable/variable_global.dart';
import 'package:dextraservice/pra_home/prahome.dart';
import 'package:location/location.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [VariableGlobal.PARRENT_COLOR, Color(0xff01A2F1)])),
      child: SizedBox(
        width: 150,
        child: new Image.asset(
          "images/logo.png",
          width: 100.0,
          height: 100.0,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 2), onDoneLoading);
  }

  onDoneLoading() async {
    final prefs = await SharedPreferences.getInstance();
    final myBool = prefs.getBool('isLogin');
    final userType = prefs.getString('userType');
    final token = prefs.getString('token');
    print("Posisi Anda   $myBool");
    if (myBool == "") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => PraHome()));
    } else if (myBool == true && userType == "user") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Dashboard()));
    } else if (myBool == true && userType == "partner") {
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => DashboardPartner()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => onBoarding()));
    }
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
   DeviceOrientation.portraitDown,
   DeviceOrientation.portraitUp,
]);

    return new MaterialApp(
      title: 'Dextra Service',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final _layoutPage= [
    Home(),
    Simpan(),
    Pesanan(),
    Profile()
  ];

  void _onTabItem(int index){
    setState(() {
          _selectedIndex = index;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layoutPage.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
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
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onTabItem,
      ),
    );
  }
}