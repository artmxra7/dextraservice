import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CardAccount extends StatefulWidget {
 

  @override
  _CardAccountState createState() => _CardAccountState();
}

class _CardAccountState extends  State<CardAccount> {

  var name, email, hp, perusahaan, referal, npwp;
  bool tampil = false;
  int wallet = 0;
  
  Future<List<String>> ambilData() async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    String url = "http://192.168.1.5:9000/api/user/profile";

    http.Response hasil = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Authorization": "Bearer ${token}",
        "Accept": "application/json"
      },
    );

    var dataBanner = json.decode(hasil.body);
    var rest = dataBanner["data"];
    this.setState(() {});
    print("data status : ${dataBanner}");
    print("data status : ${dataBanner['data']}");

    name = rest['users_name'];
      email = rest['users_email'];
      hp = rest['users_hp'];
      perusahaan = rest['users_company'];
      referal = rest['users_referral_code'];
      npwp = rest['users_npwp'];

  }
  
  @override
  void initState(){
this.ambilData();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          "$name", 
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "http://source.unsplash.com/ZHvM3XIOHoE"
              )
            )
          ),
        ),
        subtitle: Row(
          children: <Widget>[
            RaisedButton.icon(
              icon: Icon(Icons.album, color: Colors.blue,),
              label: Text('0 Poin'),
              onPressed: (){},
              color: Colors.grey[200],
              elevation: 0.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
            Padding(padding: EdgeInsets.all(8.0),),
            RaisedButton(
              child: Text('Dextra Wallet'),
              onPressed: (){},
              color: Colors.grey[200],
              elevation: 0.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            )
          ],
        ),
      ),
    );
  }
}