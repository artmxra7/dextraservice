import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    /// Declare MediaQueryData
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    /// To Sett PhotoProfile,Name and Edit Profile
    var _profile = Padding(
      padding:  EdgeInsets.only(top: 185.0, ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(

          ),
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
                  image: DecorationImage(
                      image: AssetImage("assets/img/backgroundgirl.png"))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                "Erwin Rahayu",
                style: _txtName,
              ),
            ),
            InkWell(
              onTap: null,
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Text(
                  "Edit Profile",
                  style: _txtEdit,
                ),
              ),
            ),
          ],
        ),
        Container(

        ),
      ],
      ),
    );

    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            /// Setting Header Banner
            Container(
              height: 240.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/headerProfile.png"),
                      fit: BoxFit.cover)),
            ),
            /// Calling _profile variable
            _profile,
            Padding(
              padding: const EdgeInsets.only(top: 360.0),
              child: Column(
                /// Setting Category List
                children: <Widget>[
                  /// Call category class
                  category(
                    txt: "Notification",
                    padding: 35.0,
                    image: "assets/icon/notification.png",
                    tap: () {
                      
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 85.0, right: 30.0),
                    child: Divider(
                      color: Colors.black12,
                      height: 2.0,
                    ),
                  ),
                  category(
                    txt: "Payments",
                    padding: 35.0,
                    image: "assets/icon/creditAcount.png",
                    tap: () {
                      
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 85.0, right: 30.0),
                    child: Divider(
                      color: Colors.black12,
                      height: 2.0,
                    ),
                  ),
                  category(
                    txt: "Message",
                    padding: 26.0,
                    image: "assets/icon/chat.png",
                    tap: () {
                     
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 85.0, right: 30.0),
                    child: Divider(
                      color: Colors.black12,
                      height: 2.0,
                    ),
                  ),
                  category(
                    txt: "My Orders",
                    padding: 23.0,
                    image: "assets/icon/truck.png",
                    tap: () {
                      
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 85.0, right: 30.0),
                    child: Divider(
                      color: Colors.black12,
                      height: 2.0,
                    ),
                  ),
                  category(
                    txt: "Setting Acount",
                    padding: 30.0,
                    image: "assets/icon/setting.png",
                    tap: () {
                      
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 85.0, right: 30.0),
                    child: Divider(
                      color: Colors.black12,
                      height: 2.0,
                    ),
                  ),
                  category(
                    txt: "Call Center",
                    padding: 30.0,
                    image: "assets/icon/callcenter.png",
                    tap: () {
                      
                    },
                  ),
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
                    txt: "About Apps",
                    image: "assets/icon/aboutapp.png",
                    tap: () {
                     
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
