import 'dart:async';

import 'package:dextraservice/pages/mekanik3.dart';
import 'package:flutter/material.dart';

class MekanikDua extends StatefulWidget {
  final String jobs, jobcode, brand, model, serialNumber;
  MekanikDua({this.jobs, this.jobcode, this.brand, this.model, this.serialNumber});


  @override
  _MekanikDuaState createState() => _MekanikDuaState();
}

class _MekanikDuaState extends State<MekanikDua> {

  TextEditingController permasalahan = new TextEditingController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("nama ${widget.jobs}");
    print("nama ${widget.brand}");
    print("nama ${widget.model}");
    print("nama ${widget.serialNumber}");
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
                    'Bantu Kami Untuk Mengetahui Permasalahan Anda',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: mediaQueryData.padding.top + 20.0, bottom: 0.0)),
                new ListTile(
                  leading: const Icon(Icons.report_problem),
                  title: new TextField(
                    controller: permasalahan,
                    decoration: new InputDecoration(
                      hintText: "Permasalahan",
                    ),
                  ),
                ),
                new Padding(padding: new EdgeInsets.only(top: 10.0)),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MekanikTiga(
                          jobs: widget.jobs,
                          brand: widget.brand,
                          model: widget.model,
                          serialNumber: widget.serialNumber,
                          permasalahan: permasalahan.text,
                          jobscode: widget.jobcode,
                        )));
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
