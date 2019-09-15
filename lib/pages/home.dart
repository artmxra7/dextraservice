import 'dart:convert';

import 'package:dextraservice/pages/AllProduct.dart';
import 'package:dextraservice/pages/cartAccount.dart';
import 'package:dextraservice/pages/mainMenu.dart';
import 'package:dextraservice/pages/news.dart';
import 'package:dextraservice/pages/promotion.dart';
import 'package:dextraservice/pages/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Home extends StatefulWidget {

  Home({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF6991C7)),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Dextra App',
          style: TextStyle(
              fontFamily: "Gotik",
              fontSize: 18.0,
              color: Colors.black54,
              fontWeight: FontWeight.w700),
        ),
        elevation: 0.0,
      ),
      body: Container(
        child: ListView(
            children: <Widget>[
            CardAccount(),          
            MainMenu(),
            Divider(),
            Promotion(),
            News(),
          ],
        ),
      ),

     
    );
  }

}

