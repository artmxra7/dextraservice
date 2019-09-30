import 'dart:async';

import 'package:dextraservice/pages/mekanik3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart' as prefix;

class MekanikDua extends StatefulWidget {
  @override
  _MekanikDuaState createState() => _MekanikDuaState();
}

class _MekanikDuaState extends State<MekanikDua> {
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  GoogleMapController _mapController;
  CameraPosition _position;

  int _markerIdCounter = 0;
  prefix.LocationData currentLocation;

  StreamSubscription<prefix.LocationData> _locationSubscription;
  prefix.Location _locationService = new prefix.Location();
 
  String error;
  String newLocationName;

  String _placemark = '';

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
                  leading: const Icon(Icons.person),
                  title: new TextField(
                    decoration: new InputDecoration(
                      hintText: "Permasalahan",
                    ),
                  ),
                ),
                
                
                new Padding(padding: new EdgeInsets.only(top: 10.0)),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => MekanikTiga()));
                  },
                  child:   Padding(padding: EdgeInsets.all(30.0),

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
