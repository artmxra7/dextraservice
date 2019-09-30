import 'package:cached_network_image/cached_network_image.dart';
import 'package:dextraservice/pages/NewsDetail.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  var news_code, news_title, news_content_short, news_media_link;
  List Data;
  var isLoading = false;


  Future<List<String>> ambilData() async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    String url = "https://dextra.hattadev.com/public/api/user/news";
    

    http.Response hasil = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Authorization": "Bearer ${token}",
        "Accept": "application/json"
      },
    );

    var response = await http.get(url);
    setState(() {
   isLoading = true;
    });
    if (response.statusCode == 200) {
      var dataBanner = json.decode(hasil.body);
   
      print("JsonResponse : $dataBanner.");

      setState(() {
        
      Data =  dataBanner["data"];

      isLoading = false;

      return "Succesfull";
    });
    } else {
      print("Request Failed");
    }

   
  }

  @override
  void initState(){
    this.ambilData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
            
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              "News",
              style: TextStyle(
                  fontFamily: "Gotik",
                  fontSize: 18.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w700),
            ),
            elevation: 0.0,
          ),
          body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            :  _buildNews(),
    );
  }

  
Widget _buildNews(){
  return ListView.builder(
    padding: const EdgeInsets.all(16.0),
    itemCount: Data == null ? 0 : Data.length,
    shrinkWrap: true,
    itemBuilder: (context, index){
      return GestureDetector(
        onTap: ()
        {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return NewsDetail(title: 'id', content: 'Name');
        }));
      },
      child: _buildImageColumn(Data[index]),
      );    
    },
  );
}
}




Widget _buildImageColumn(item) => Container(

  decoration: BoxDecoration(
    color:  Colors.blue[50]
  ),
  margin: const EdgeInsets.all(8),
  child: Column(
    children: <Widget>[
      new CachedNetworkImage(
        imageUrl: item['news_media_link'],
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Text("Image Not Found"),
      ),
      ListTile(
        title: Text(item['news_title']),
      )
    ],
  ),

);



class noItemCart extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return  Container(
      width: 500.0,
      color: Colors.white,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                EdgeInsets.only(top: mediaQueryData.padding.top + 50.0)),
            Image.asset(
              "assets/imgIllustration/IlustrasiCart.png",
              height: 300.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Text(
              "Not Have Item",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.5,
                  color: Colors.black26.withOpacity(0.2),
                  fontFamily: "Popins"),
            ),
          ],
        ),
      ),
    );
  }
}