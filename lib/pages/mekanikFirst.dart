import 'dart:async';

import 'package:dextraservice/pages/mekanik.dart';
import 'package:flutter/material.dart';

class MekanikFirst extends StatefulWidget {
  @override
  _MekanikFirstState createState() => _MekanikFirstState();
}

class _MekanikFirstState extends State<MekanikFirst> {
  List<String> list = [
    'Dart',
    'Java',
    'C',
    'C++',
    'C#',
    'Kotlin',
    'JavaScript'
  ];
  String item = 'Dart';

  void onChanged(String value) {
    setState(() {
      item = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.width;
    mediaQueryData.size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.white,
        child: Form(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Jenis Bantuan Mekanik yang Anda Butuhkan',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: mediaQueryData.padding.top + 20.0, bottom: 0.0)),
                new ListTile(
                  leading: const Icon(
                    IconData(0xe801, fontFamily: 'mechanic'),
                  ),
                  title: itemDropDown(),
                ),
                new Padding(padding: new EdgeInsets.only(top: 10.0)),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Mekanik()));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Container(
                      height: 55.0,
                      width: 600.0,
                      child: Text(
                        "Lanjut",
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
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemDropDown() {
    return new DropdownButton(
      isExpanded: true,
      value: item,
      items: list.map((String val) {
        return DropdownMenuItem(
          value: val,
          child: Row(
            children: <Widget>[Text(val)],
          ),
        );
      }).toList(),
      hint: new Text("Select City"),
      onChanged: (String value) {
        onChanged(value);
      },
    );
  }
}
