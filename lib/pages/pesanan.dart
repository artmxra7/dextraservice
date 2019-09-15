import 'package:flutter/material.dart';

class Pesanan extends StatefulWidget {
  @override
  _PesananState createState() => _PesananState();
}

class _PesananState extends State<Pesanan> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
            iconTheme: IconThemeData(color: Color(0xFF6991C7)),
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              "Chart",
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

class noItemCart extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return  Container(
      width: 500.0,
      color: Colors.white,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                EdgeInsets.only(top: mediaQueryData.padding.top + 50.0)),
            Image.asset(
              "assets/imgIllustration/IlustrasiCart.png",
              height: 300.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Text(
              "Not Have Item",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.5,
                  color: Colors.black26.withOpacity(0.2),
                  fontFamily: "Popins"),
            ),
          ],
        ),
      ),
    );
  }
}