import 'package:dextraservice/Screen/flash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class DextraService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Set color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));
    return new MaterialApp(
      title: "Dextra App",
      theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          primaryColorLight: Colors.white,
          primaryColorBrightness: Brightness.light),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}