
import 'package:dextraservice/app/app.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {  
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
    runApp(DextraService());
  });
}
