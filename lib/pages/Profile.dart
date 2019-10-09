import 'package:dextraservice/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

/// Custom Font
var _txt = TextStyle(
  color: Colors.black,
  fontFamily: "Sans",
);

/// Get _txt and custom value of Variable for Name User
var _txtName = _txt.copyWith(fontWeight: FontWeight.w700, fontSize: 17.0);

/// Get _txt and custom value of Variable for Edit text
var _txtEdit = _txt.copyWith(color: Colors.black26, fontSize: 15.0);

/// Get _txt and custom value of Variable for Category Text
var _txtCategory = _txt.copyWith(
    fontSize: 14.5, color: Colors.black54, fontWeight: FontWeight.w500);

class _ProfilState extends State<Profile> {
  SharedPreferences _prefs;

  doLogout() async {
    _prefs = await SharedPreferences.getInstance();

    _prefs.remove('isLogin');
    _prefs.remove('token');
    _prefs.remove('users_name');

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => loginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    /// Declare MediaQueryData
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    /// To Sett PhotoProfile,Name and Edit Profile
    var _profile = Padding(
      padding: EdgeInsets.only(
        top: 15.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2.5),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          Container(),
        ],
      ),
    );

    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            /// Calling _profile variable
            _profile,
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                /// Setting Category List
                children: <Widget>[
                  /// Call category class

                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 85.0, right: 30.0),
                    child: Divider(
                      color: Colors.black12,
                      height: 2.0,
                    ),
                  ),
                  category(
                    padding: 38.0,
                    txt: "Logout",
                    image: "assets/icon/aboutapp.png",
                    tap: () {
                      doLogout();
                    },
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20.0)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Component category class to set list
class category extends StatelessWidget {
  @override
  String txt, image;
  GestureTapCallback tap;
  double padding;

  category({this.txt, this.image, this.tap, this.padding});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 30.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: padding),
                  child: Image.asset(
                    image,
                    height: 25.0,
                  ),
                ),
                Text(
                  txt,
                  style: _txtCategory,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
