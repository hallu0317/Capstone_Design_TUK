// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RegionReservation extends StatelessWidget {
  final String region;
  const RegionReservation({Key? key, required this.region}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RegionReservation',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[400],
          title: Text(
            region + " 호텔 예약",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          elevation: 0.0, //앱바의 입체감을 없애주기위함
          centerTitle: true,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: TextButton(
              onPressed: () {
                print(region);
              },
              child: Text(region),
            ),
          )
        ]),
      ),
    );
  }
}
