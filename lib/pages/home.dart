import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    

  SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitDown,
  DeviceOrientation.portraitUp,
]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dextra',
      theme: ThemeData(
        fontFamily: 'MaisonNeue',
        backgroundColor: Colors.white,
      ),
      home: MyHomePage(title: 'Dextra Service'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Akun(),
          Divider(),
          MenuUtama(),
          // MenuTambahan(),
          Promo(),
        ],
      ),
    );
  }
}

class Akun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "https://source.unsplash.com/ZHvM3XIOHoE/"))),
        ),
        title: Text(
          "User Name",
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'MaisonNeue'),
        ),
      //   subtitle: Row(
      //     children: <Widget>[
      //       RaisedButton.icon(
      //         icon: Icon(Icons.album),
      //         label: Text("0 Poin"),
      //         onPressed: () {},
      //         color: Colors.grey[200],
      //         elevation: 0.0,
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(8.0)),
      //       ),
      //       Padding(
      //         padding: EdgeInsets.all(8.0),
      //       ),
      //       RaisedButton(
      //         child: Text("Dextra Pay"),
      //         onPressed: () {},
      //         color: Colors.grey[200],
      //         elevation: 0.0,
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(8.0)),
      //       )
      //     ],
      //   ),
      ),
    );
  }
}

class MenuUtama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 150) / 2;
    final double itemWidth = size.width / 2;
    return GridView.count(
      scrollDirection: Axis.vertical,
      childAspectRatio: (itemWidth / itemHeight),
      shrinkWrap: true,
      crossAxisCount: 4,
      children: menuUtamaItem,
    );
  }
}

List<MenuUtamaItems> menuUtamaItem = [
  MenuUtamaItems(
    title: "Mechanic",
    icon: IconData(0xe800, fontFamily: 'mechanic'),
    colorBox: Colors.blue,
    colorIcon: Colors.white,
  ),
  MenuUtamaItems(
    title: "Spareparts",
    icon: IconData(0xe800, fontFamily: 'mechanic'),
    colorBox: Colors.blue[900],
    colorIcon: Colors.white,
  ),
  MenuUtamaItems(
    title: "Equipment",
    icon: IconData(0xe800, fontFamily: 'mechanic'),
    colorBox: Colors.blue[900],
    colorIcon: Colors.white,
  ),
  MenuUtamaItems(
    title: "Rental",
    icon: IconData(0xe800, fontFamily: 'mechanic'),
    colorBox: Colors.blue[900],
    colorIcon: Colors.white,
  )
];

class MenuUtamaItems extends StatelessWidget {
  MenuUtamaItems({this.title, this.icon, this.colorBox, this.colorIcon});
  final String title;
  final IconData icon;
  final Color colorBox, colorIcon;
  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: <Widget>[
        Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: colorBox,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: colorIcon,
            )),
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(
            title,
            style: TextStyle(
              
              fontSize: 12.0,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

class MenuTambahan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      height: 100.0,
      child: ListView(
        
        scrollDirection: Axis.horizontal,
        children: menuTambahan,
      ),
    );
  }
}

List<MenuTambahanItems> menuTambahan = [
  MenuTambahanItems(
    title: 'Tagihan & Isi Ulang',
    icon: Icons.receipt,
  ),
  MenuTambahanItems(
    title: 'Internet Luar Negeri',
    icon: Icons.data_usage,
  ),
  MenuTambahanItems(
    title: 'Bioskop',
    icon: Icons.movie,
  ),
  MenuTambahanItems(
    title: 'PayLater',
    icon: Icons.payment,
  ),
  MenuTambahanItems(
    title: 'Status Penerbangan',
    icon: Icons.airplanemode_active,
  ),
  MenuTambahanItems(
    title: 'Pulsa & Paket Internet',
    icon: Icons.signal_cellular_4_bar,
  ),
  MenuTambahanItems(
    title: 'Online Check-In',
    icon: Icons.airplanemode_inactive,
  ),
  MenuTambahanItems(
    title: 'Notifikasi Harga',
    icon: Icons.notifications,
  ),
];

class MenuTambahanItems extends StatelessWidget {
  MenuTambahanItems({this.title, this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      child: Column(
        children: <Widget>[
          Icon(icon),
          Text(
            title,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class Promo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'Promo Saat Ini',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22.0),
          ),
          trailing: IconButton(
            icon: Icon(Icons.keyboard_arrow_right),
            onPressed: () {},
          ),
        ),
        Container(
          width: double.infinity,
          height: 150.0,
          padding: const EdgeInsets.only(left: 8.0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blue,
                        Colors.blue[800],
                      ]),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                // padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.only(left: 8.0),
                height: 150.0,
                width: 100.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red[300],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(20.0,20.0),
                          bottomRight: Radius.elliptical(150.0, 150.0)
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2.0, left: 5.0, right: 30.0, bottom: 30.0),
                        child: Text('%', style: TextStyle(fontSize: 24.0,color: Colors.white),),
                      )),
                    Expanded(
                      child: Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Lihat Semua \nPromo',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 18.0),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.blue,
                          Colors.blue[800],
                        ]),
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                        image: AssetImage('images/promo.jpeg'))),
                margin: EdgeInsets.only(left: 10.0),
                height: 150.0,
                width: 300.0,
                child: null,
              )
            ],
          ),
        )
      ],
    );
  }
}