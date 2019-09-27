import 'package:dextraservice/config.dart' as prefix1;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:dextraservice/Model/placeItem.dart';

class PlaceService {
  static Future<List<PlaceItemRes>> searchPlace(String keyword) async {
    String language = prefix1.language;
    String region = prefix1.region;
    String apiKey = prefix1.ApiKey;
    String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?key=$apiKey&language=$language&region=$region&query=" +Uri.encodeQueryComponent(keyword);
    HttpClient client = new HttpClient();

    //var res = await http.get(url);
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    return PlaceItemRes.fromJson(json.decode(responseBody));
//    if (res.statusCode == 200) {
//      print(PlaceItemRes.fromJson(json.decode(res.body)));
//      return PlaceItemRes.fromJson(json.decode(res.body));
//    } else {
//      return new List();
//    }
  }
}