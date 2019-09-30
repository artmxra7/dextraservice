import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CardAccount extends StatefulWidget { 

  final String users_name;

  CardAccount({
    this.users_name
  });


  @override
  _CardAccountState createState() => _CardAccountState();
}

class _CardAccountState extends State<CardAccount> {

  var name;
  String thisUsersName;
  int wallet = 0;

  var isLoading = false;
  
  
  Future<List<String>> ambilData() async {

    setState(() {
         isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    String url = "https://dextra.hattadev.com/public/api/user/profile";

    http.Response hasil = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Authorization": "Bearer ${token}",
        "Accept": "application/json"
      },
    );
    
    var response = await http.get(url);    
    
    if (response.statusCode == 200){

    var dataBanner = json.decode(hasil.body);
    var rest = dataBanner["data"];
    // print("data status : ${dataBanner}");
    // print("data status : ${dataBanner['data']}");
   

    name = rest['users_name'];

    prefs.setString('users_name', name);

    print("data status : ${name}");
 

     setState(() {
      isLoading = false; //Data has loaded
    });
    
    }

  }
  
  @override
  void initState(){    
    this.ambilData();    
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return isLoading ? Center(
      child: CircularProgressIndicator(),
    ) : Container(

      child: Padding(
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
    ),
    );
    
  }
}