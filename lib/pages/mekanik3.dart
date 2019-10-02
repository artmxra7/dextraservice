import 'dart:async';

import 'package:dextraservice/Components/historyTrip.dart';
import 'package:dextraservice/pages/OrderConfirm.dart';
import 'package:dextraservice/pages/SearchAddress2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart' as prefix;

class MekanikTiga extends StatefulWidget {
  final String jobs, brand, model, serialNumber, permasalahan;

  List<Map<String, dynamic>> thisLocation;
  MekanikTiga(
      {this.jobs,
      this.brand,
      this.model,
      this.serialNumber,
      this.permasalahan,
      this.thisLocation});

  @override
  _MekanikTigaState createState() => _MekanikTigaState();
}

class _MekanikTigaState extends State<MekanikTiga> {
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
  void initState() {
    super.initState();
    _getCurrentLocation2();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getCurrentLocation2() async {
    _locationSubscription = _locationService
        .onLocationChanged()
        .listen((prefix.LocationData result) {
      setState(() {
        currentLocation = result;
      });
    });
    prefix.LocationData myLocation;
    try {
      myLocation = await _locationService.getLocation();
    } on PlatformException catch (e) {
      print(e);
    }
  }

  void _onMapCreated(GoogleMapController controller) async {
    if (widget.thisLocation != null) {
      this._mapController = controller;
      MarkerId markerId = MarkerId(_markerIdVal());
      LatLng position = LatLng(
          currentLocation != null ? currentLocation.latitude : 0.0,
          currentLocation != null ? currentLocation.longitude : 0.0);
      Marker marker = Marker(
        markerId: markerId,
        position: position,
        draggable: false,
      );
      setState(() {
        _markers[markerId] = marker;
      });

      Future.delayed(Duration(milliseconds: 200), () async {
        this._mapController = controller;
        controller?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(widget.thisLocation[0]['lat'],
                  widget.thisLocation[0]['long']),
              zoom: 15.0,
            ),
          ),
        );
      });
    } else {
      this._mapController = controller;
      MarkerId markerId = MarkerId(_markerIdVal());
      LatLng position = LatLng(
          currentLocation != null ? currentLocation.latitude : 0.0,
          currentLocation != null ? currentLocation.longitude : 0.0);
      Marker marker = Marker(
        markerId: markerId,
        position: position,
        draggable: false,
      );
      setState(() {
        _markers[markerId] = marker;
      });

      Future.delayed(Duration(milliseconds: 200), () async {
        this._mapController = controller;
        controller?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: position,
              zoom: 15.0,
            ),
          ),
        );
      });
    }
  }

  String _markerIdVal({bool increment = false}) {
    String val = 'marker_id_$_markerIdCounter';
    if (increment) _markerIdCounter++;
    return val;
  }

  void getLocationName(double lat, double lng) async {
    List<Placemark> placemarks =
        await Geolocator().placemarkFromCoordinates(lat, lng);
    if (placemarks != null && placemarks.isNotEmpty) {
      final Placemark pos = placemarks[0];
      setState(() {
        _placemark = pos.name + ', ' + pos.thoroughfare;
        newLocationName = _placemark;
        print(newLocationName);
      });
    }
  }

  void moveCameraToMyLocation() {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: 17.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.width;
    mediaQueryData.size.height;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.white,
        child: Form(
          child: Container(
            child: ListView(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Tentukan Lokasi Untuk Kedatangan Team Kami',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                          child: Text(
                            'Lokasi Anda Saat ini:',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          )),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => SearchAddress2(
                                          newLocationName != null
                                              ? newLocationName
                                              : "",
                                          _position,
                                        ),
                                    fullscreenDialog: true));
                          },
                          child: HistoryTrip(
                            fromAddress:
                                newLocationName != null ? newLocationName : "",
                          )),
                      new ListTile(
                        leading: const Icon(Icons.person_pin_circle),
                        title: new TextField(
                          decoration: new InputDecoration(
                            hintText: "Detail Alamat, Telephone",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width - 110,
                  child: GoogleMap(
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                      new Factory<OneSequenceGestureRecognizer>(
                        () => new EagerGestureRecognizer(),
                      ),
                    ].toSet(),
                    markers: Set<Marker>.of(_markers.values),
                    onMapCreated: _onMapCreated,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    compassEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          currentLocation != null
                              ? currentLocation.latitude
                              : 0.0,
                          currentLocation != null
                              ? currentLocation.longitude
                              : 0.0),
                      zoom: 12.0,
                    ),
                    onCameraMove: (CameraPosition position) {
                      if (_markers.length > 0) {
                        MarkerId markerId = MarkerId(_markerIdVal());
                        Marker marker = _markers[markerId];
                        Marker updatedMarker = marker.copyWith(
                          positionParam: position.target,
                        );
                        setState(() {
                          _markers[markerId] = updatedMarker;
                          _position = position;
                        });
                      }
                    },
                    onCameraIdle: () => getLocationName(
                        _position.target.latitude != null
                            ? _position.target.latitude
                            : currentLocation.latitude,
                        _position.target.longitude != null
                            ? _position.target.longitude
                            : currentLocation.longitude),
                  ),
                ),
                new Padding(padding: new EdgeInsets.only(top: 10.0)),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OrderConfirm(
                              jobs: widget.jobs,
                              brand: widget.brand,
                              model: widget.model,
                              serialNumber: widget.serialNumber,
                              lokasi: newLocationName,
                              permasalahan: widget.permasalahan,
                              latitude: _position.target.latitude.toString(),
                              longtitude: _position.target.longitude.toString(),

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
