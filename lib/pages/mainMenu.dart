import 'package:dextraservice/pages/mekanik.dart';
import 'package:flutter/material.dart';

import '../pages/allProduct.dart';
import '../pages/screen.dart';

List<MainMenuItem> mainMenuItem = [
  MainMenuItem(
      title: 'Mechanic',
      icon: IconData(0xe801, fontFamily: 'mechanic'),
      colorBox: Colors.blue,
      iconColor: Colors.white,
      screenWidget: Mekanik()),
  MainMenuItem(
      title: 'Spareparts',
      icon: IconData(0xe801, fontFamily: 'carparts'),
      colorBox: Colors.blue[900],
      iconColor: Colors.white,
      screenTitle: 'Spareparts',
      screenContent: 'Maaf Data Belum Tersedia'),
  MainMenuItem(
      title: 'Equipment',
      icon: IconData(0xe802, fontFamily: 'equipment'),
      colorBox: Colors.purple,
      iconColor: Colors.white,
      screenTitle: 'Equipment',
      screenContent: 'Maaf Data Belum Tersedia'),
  MainMenuItem(
      title: 'Rental',
      icon: IconData(0xe800, fontFamily: 'rental'),
      colorBox: Colors.green[300],
      iconColor: Colors.white,
      screenTitle: 'Rental',
      screenContent: 'Maaf Data Belum Tersedia')
//   MainMenuItem(
//       title: 'Eats',
//       icon: Icons.local_dining,
//       colorBox: Colors.orange,
//       iconColor: Colors.white,
//       screenTitle: 'Search Food',
//       screenContent: 'Makanan'),
//   MainMenuItem(
//       title: 'Trains',
//       icon: Icons.train,
//       colorBox: Colors.orange[300],
//       iconColor: Colors.white,
//       screenTitle: 'Search Train',
//       screenContent: 'Pencarian Kereta'),
//   MainMenuItem(
//       title: 'Bus & Shuttle',
//       icon: Icons.directions_bus,
//       colorBox: Colors.green,
//       iconColor: Colors.white,
//       screenTitle: 'Search Bus & Shuttle',
//       screenContent: 'Pencarian Bus & Shuttle'),
//   MainMenuItem(
//       title: 'Airport Transfer',
//       icon: Icons.hotel,
//       colorBox: Colors.blue[300],
//       iconColor: Colors.white,
//       screenTitle: 'Search Airport Transfer',
//       screenContent: 'Search Airport Transfer'),
//   MainMenuItem(
//       title: 'Car Rental',
//       icon: Icons.hotel,
//       colorBox: Colors.green[900],
//       iconColor: Colors.white,
//       screenTitle: 'Search Car Rental',
//       screenContent: 'Pencarian Rental Mobil'),
//   MainMenuItem(
//       title: 'All Products',
//       icon: Icons.apps,
//       colorBox: Colors.grey,
//       iconColor: Colors.white,
//       screenWidget: AllProduct()),
];

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      childAspectRatio: 1.0,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 4.0,
      children: mainMenuItem,
    );
  }
}

class MainMenuItem extends StatelessWidget {
  final String title, screenTitle, screenContent;
  final IconData icon;
  final Color colorBox, iconColor;
  final Widget screenWidget;

  MainMenuItem(
      {this.title,
      this.icon,
      this.colorBox,
      this.iconColor,
      this.screenTitle,
      this.screenContent,
      this.screenWidget});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: colorBox,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(icon, color: iconColor),
              onPressed: () {
                Route route = MaterialPageRoute(builder: (context) {
                  if (screenWidget == null) {
                    return ScreenGeneral(
                      title: screenTitle,
                      content: screenContent,
                    );
                  }

                  return screenWidget;
                });

                Navigator.of(context).push(route);
              },
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(
              top: 2.0,
            ),
            child: Text(title,
                style: TextStyle(fontSize: 12.0), textAlign: TextAlign.center))
      ],
    );
  }
}
