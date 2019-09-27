import 'package:flutter/material.dart';




class News extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,

      children: <Widget>[
        ListTile(
          title: Text('Recommend News', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),),
          trailing: IconButton(
            icon: Icon(Icons.keyboard_arrow_right),
            onPressed: (){},
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 8.0),
          height: 150.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                height: 150.0,
                width: 150.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue,
                      Colors.blue[600]
                    ]
                  ),
                  borderRadius: BorderRadius.circular(8.0)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                   
                    Expanded(child: Container(),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('See all \nNews', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18.0),),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
  
}