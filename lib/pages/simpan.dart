import 'package:flutter/material.dart';

class Simpan extends StatefulWidget {
  @override
  _SimpanState createState() => _SimpanState();
}

class _SimpanState extends State<Simpan> {
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
            iconTheme: IconThemeData(color: Color(0xFF6991C7)),
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              "Quotes",
              style: TextStyle(
                  fontFamily: "Gotik",
                  fontSize: 18.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w700),
            ),
            elevation: 0.0,
          ),

          body: ListView(

          ), 
          ///
          ///
          /// Checking item value of cart
          ///
          /// noItem
    );
  }
}