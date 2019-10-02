import 'dart:async';

import 'package:dextraservice/pages/mekanik2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:location/location.dart' as prefix;
import 'package:progress_dialog/progress_dialog.dart';

class Mekanik extends StatefulWidget {
  final String jobs;
  Mekanik ({
    this.jobs
  });
  

  @override
  _MekanikState createState() => _MekanikState();
}

class _MekanikState extends State<Mekanik> {


  ProgressDialog pr;
  TextEditingController brand = new TextEditingController();
  TextEditingController model = new TextEditingController();
  TextEditingController serialNumber = new TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("nama ${widget.jobs}");
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
                    'Tolong Bantu Kami Untuk Mengetahui Part Anda',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: mediaQueryData.padding.top + 20.0, bottom: 0.0)),
                new ListTile(
                  leading: const Icon(Icons.branding_watermark),
                  title: new TextField(
                    controller: brand,
                    decoration: new InputDecoration(
                      hintText: "Brand",
                    ),
                  ),
                ),
                new ListTile(
                  leading: const Icon(Icons.view_module),
                  title: new TextField(
                    controller: model,
                    decoration: new InputDecoration(
                      hintText: "Model",
                    ),
                  ),
                ),
                new ListTile(
                  leading: const Icon(Icons.list),
                  title: new TextField(
                    controller: serialNumber,
                    decoration: new InputDecoration(
                      hintText: "Serial Number",
                    ),
                  ),
                ),
                new Padding(padding: new EdgeInsets.only(top: 10.0)),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MekanikDua(jobs: widget.jobs,
                        brand: brand.text,
                        model: model.text,
                        serialNumber: serialNumber.text,)));
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
}
