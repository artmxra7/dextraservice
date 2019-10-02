import 'package:dextraservice/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bodyProgress = SpinKitRipple (color: primaryColor ,size: 500.0, borderWidth: 20.0, );
    return bodyProgress;
  }
}
//SpinKitRipple(color: primaryColor),