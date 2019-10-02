import 'package:dextraservice/Blocs/place_bloc.dart';
import 'package:dextraservice/Model/placeItem.dart';
import 'package:dextraservice/pages/mekanik3.dart';
import 'package:dextraservice/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';

class SearchAddress2 extends StatefulWidget {
 
  final String nameAddressFrom;
  CameraPosition addressFrom;
  SearchAddress2(this.nameAddressFrom, this.addressFrom);

  @override
  _SearchAddress2State createState() => _SearchAddress2State();
}

class _SearchAddress2State extends State<SearchAddress2> {
  var _addressFrom, _addressTo;
  var placeBloc = PlaceBloc();
  String valueFrom,valueTo;
  bool checkAutoFocus = false,inputFrom = false,inputTo = false;
  FocusNode nodeFrom = FocusNode();
  FocusNode nodeTo = FocusNode();
  List<Map<String, dynamic>> dataFrom = new List<Map<String, dynamic>>();
  List<Map<String, dynamic>> dataTo = new List<Map<String, dynamic>>();


  @override
  void initState() {
    _addressFrom = TextEditingController(text: widget.nameAddressFrom);
    getCurrentAddFrom();
    super.initState();
  }
  @override
  void dispose() {
    placeBloc.dispose();
    super.dispose();
  }

  getCurrentAddFrom(){
    Map<String, dynamic> value = {"name" : widget.nameAddressFrom,"address" : "", "lat" : widget.addressFrom.target.latitude, "long" : widget.addressFrom.target.longitude};
    setState(() {
      dataFrom.add(value);
      print(dataFrom);
    });
  }

  navigator(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => MekanikTiga(thisLocation: dataFrom,))
    );   
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: whiteColor,
        elevation: 2.0,
        title: Text("Search address",
          style: TextStyle(color: blackColor),
        ),
        iconTheme: IconThemeData(
            color: blackColor
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: greyColor,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                color: whiteColor,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  new Expanded(
                    flex: 1,
                    child: new Column(
                      children: <Widget>[
                        new Icon(Icons.my_location,size: 20.0,color: Colors.blue,),
                      ],
                    ),
                  ),
                  new Expanded(
                    flex: 5,
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Container(
                            height: 50.0,
                            width: MediaQuery.of(context).size.width - 50,
                            color: Colors.white,
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextField(
                                  style: textStyle,
                                  decoration: InputDecoration.collapsed(
                                    fillColor: whiteColor,
                                    hintStyle: TextStyle(color: greyColor),
                                    hintText: "Cari Lokasi"
                                  ),
                                  autofocus: true,
                                  focusNode: nodeFrom,
                                  controller: _addressFrom,
                                  onChanged: (String value){
                                    placeBloc.searchPlace(value);
                                  },
                                  onTap: (){
                                    setState(() {
                                      inputFrom = true;
                                      inputTo = true;
                                      print(inputTo);
                                    });
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  ],
                ),
              ),
              inputTo != true ? Container(
                color: whiteColor,
                child: StreamBuilder(
                  stream: placeBloc.placeStream,
                  builder: (context, snapshot){
                    if (snapshot.hasData){
                      if (snapshot.data == "start") {
                        return Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                      List<PlaceItemRes> places = snapshot.data;
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: places.length,
                        itemBuilder: (context, index){
                          return ListTile(
                            title: Text(places.elementAt(index).name),
                            subtitle: Text(places.elementAt(index).name),
                            onTap: (){
                              dataFrom.clear();
                              Map<String, dynamic> value = {"name" : places.elementAt(index).name, "address" :
                              places.elementAt(index).address, "lat" : places.elementAt(index).lat, "long" : 
                              places.elementAt(index).lng};
                              setState(() {
                                valueFrom = places.elementAt(index).name.toString();
                                _addressFrom = TextEditingController(text: valueFrom);
                                inputTo = true;
                                FocusScope.of(context).requestFocus(nodeTo);

                                dataFrom.add(value);
                                print(dataFrom);
                              });
                            },
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          color: Color(0xfff5f5f5),
                        ),

                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ) : Container(
                color: greyColor,
                child:  StreamBuilder(
                  stream: placeBloc.placeStream,
                  builder: (context, snapshot){
                    if (snapshot.hasData){
                      if (snapshot.data == "start"){
                        return Center(
                          child:  CupertinoActivityIndicator(),
                        );
                      }
                      List<PlaceItemRes> places = snapshot.data;
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: places.length,
                        itemBuilder: (context, index){
                          return ListTile(
                            title: Text(places.elementAt(index).name),
                            subtitle: Text(places.elementAt(index).address),
                            onTap: () {
                                dataTo.clear();
                                Map<String, dynamic> value = {"name" : places.elementAt(index).name,"address" : places.elementAt(index).address, "lat" : places.elementAt(index).lat, "long" : places.elementAt(index).lng};
                                setState(() {
                                  valueTo = places.elementAt(index).name.toString();
                                  _addressTo = TextEditingController(text: places.elementAt(index).name.toString());
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  dataTo.add(value);
                                  print(dataTo);
                                  //directions
                                  navigator();
                                });
                              },
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                            height: 1,
                            color: Color(0xfff5f5f5),
                          ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
