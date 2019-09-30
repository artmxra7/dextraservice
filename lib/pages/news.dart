import 'package:dextraservice/pages/NewList.dart';
import 'package:flutter/material.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text(
            'Recommend News',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          ),
          trailing: IconButton(
            icon: Icon(Icons.keyboard_arrow_right),
            onPressed: () {},
          ),
        ),
        ReadAll(),
      ],
    );
  }
}

class ReadAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 8.0),
      height: 150.0,
      child: new ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => NewsList()));
            },
            child: Container(
              height: 150.0,
              width: 150.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue, Colors.blue[600]]),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'See all \nNews',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListItem()
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      height: 150.0,
      width: 300.0,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text(
              'News Title',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 18.0),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.blue[800]]),
        borderRadius: BorderRadius.circular(8.0),
        // image: DecorationImage(image: AssetImage(''))
      ),
    );
  }
}
