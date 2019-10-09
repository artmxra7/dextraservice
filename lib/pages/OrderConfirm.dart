import 'dart:async';

import 'package:dextraservice/pages/findMekanik.dart';
import 'package:dextraservice/pages/mekanik2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:location/location.dart' as prefix;
import 'package:progress_dialog/progress_dialog.dart';

class OrderConfirm extends StatefulWidget {
  final String jobs, jobscode, brand, model, serialNumber, permasalahan, lokasi, latitude, longtitude, detailalamat;

  OrderConfirm(
      {this.jobs,
      this.jobscode,
      this.brand,
      this.model,
      this.serialNumber,
      this.permasalahan,
      this.lokasi,
      this.latitude,
      this.longtitude,
      this.detailalamat});

  @override
  _OrderConfirmState createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  ProgressDialog pr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("nama ${widget.latitude}");
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
            padding: EdgeInsets.all(0.0),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 30.0, 0.0, 40.0),
                  child: Text(
                    'Konfirmasi Order ',
                    style:
                        TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                  child: Text(
                    'Jenis Bantuan :',
                    style:
                        TextStyle(fontSize: 14.0,),
                  ),
                ),

                Container(
                  
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                  child: Text(
                    '${widget.jobs}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),

                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                  child: Text(
                    'Brand Parts :',
                   style:
                        TextStyle(fontSize: 14.0,),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                  child: Text(
                    '${widget.brand}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),

                  ],
                ),


                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                  child: Text(
                    'Model Parts :',
                   style:
                        TextStyle(fontSize: 14.0,),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                  child: Text(
                    '${widget.model}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),

                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                  child: Text(
                    'Serial Number:',
                    style:
                        TextStyle(fontSize: 14.0,),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                  child: Text(
                    '${widget.serialNumber}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),

                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                  child: Text(
                    'Jenis Masalah:',
                   style:
                        TextStyle(fontSize: 14.0,),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                  child: Text(
                    '${widget.permasalahan}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),

                  ],
                ),

                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                  child: Text(
                    'Lokasi:',
                   style:
                        TextStyle(fontSize: 14.0,),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                  child: Text(
                    '${widget.lokasi}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),

                  ],
                ),

                Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                  child: Text(
                    'Detail Lokasi:',
                   style:
                        TextStyle(fontSize: 14.0,),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                  child: Text(
                    '${widget.detailalamat}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),

                  ],
                ),


          

                
                
                new Padding(padding: new EdgeInsets.only(top: 10.0)),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FindMekanik(
                          jobscode: widget.jobscode,
                          brand: widget.brand,
                          model: widget.model,
                          serialNumber: widget.serialNumber,
                          permasalahan: widget.permasalahan,
                          lokasi: widget.lokasi,
                          detailokasi: widget.detailalamat,
                          latitude: widget.latitude,
                          longtitude: widget.longtitude,
                          
                            )));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Container(
                      height: 55.0,
                      width: 600.0,
                      child: Text(
                        "Pesan Sekarang",
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
