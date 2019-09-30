import 'package:flutter/material.dart';

void alertDialog(BuildContext context, String str) {
  if (str.isEmpty) return;

  AlertDialog alertDialog = new AlertDialog(
    content: new Text(
      str,
      style: new TextStyle(fontSize: 20.0),
    ),
    actions: <Widget>[
      new FlatButton(
        child: new Text("OK"),
        onPressed: () {
          //ketika button di klik maka akan dismis dialog
          Navigator.pop(context);
        },
      ),
    ],
  );

  showDialog(context: context, child: alertDialog);
}

abstract class IsSilly {
  void makePeopleLaugh();
}
