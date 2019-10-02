import 'dart:async';
import 'dart:convert';

import 'package:dextraservice/Model/MasterJobList.dart';
import 'package:dextraservice/Model/response.dart';
import 'package:dextraservice/pages/mekanik.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MekanikFirst extends StatefulWidget {
  @override
  _MekanikFirstState createState() => _MekanikFirstState();
}

class _MekanikFirstState extends State<MekanikFirst> {
  JobList selectedJobList = null;

  List<JobList> jobList = new List<JobList>();

  Future<List<JobList>> _getJobList() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    String url = "https://dextra.hattadev.com/public/api/user/job_categories";

    http.Response hasil = await http.get(Uri.encodeFull(url), headers: {
      "Authorization": "Bearer ${token}",
      "Accept": "application/json"
    });

    var thisData = json.decode(hasil.body);
    var restData = thisData["data"];

    if (thisData["code"] == 0) {
      

      jobList = new List<JobList>();

      for (var jobs in restData) {
        String id = jobs["job_categories_code"].toString();
        String name = jobs["name"].toString();
        jobList.add(new JobList(id: id, name: name));
      }
      setState(() {});
    } else {
      
      throw Exception('Failed to load internet');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getJobList();
    
  }

  void onChanged(value) {
    setState(() {
      selectedJobList = value;
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
                        MaterialPageRoute(builder: (context) => new Mekanik(jobs: selectedJobList.name)));
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
    return new DropdownButton<JobList>(
      isExpanded: true,
      value: selectedJobList,
      items: jobList.map((JobList map) {
        return DropdownMenuItem<JobList>(
          value: map,
          child: new Text(map.name, style: new TextStyle(color: Colors.black)),
        );
      }).toList(),
      hint: new Text("Pilih Jenis Bantuan"),
      onChanged: (value) {
        setState(() {
          selectedJobList = value;
          print("Selected value " + selectedJobList.name);
        });
      },
    );
  }
}
