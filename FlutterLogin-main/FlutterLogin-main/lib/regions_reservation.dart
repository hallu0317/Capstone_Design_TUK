// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RegionReservation extends StatelessWidget {
  const RegionReservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RegionReservation',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[400],
          title: Text(
            "Room Reservation",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          elevation: 0.0, //앱바의 입체감을 없애주기위함
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Image(image: AssetImage("img/room_img/Single.PNG")),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Image(image: AssetImage("img/room_img/Deluxe.PNG")),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Image(image: AssetImage("img/room_img/Executive.PNG")),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Image(image: AssetImage("img/room_img/Suite.PNG")),
            )
          ]),
        ),
      ),
    );
  }
}
