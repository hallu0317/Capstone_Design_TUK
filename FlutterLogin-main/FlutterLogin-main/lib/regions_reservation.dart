// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/fireStore.dart';
import 'package:flutter_login/mainHome.dart';
import 'package:flutter_login/myProfile.dart';
import 'package:flutter_login/regions_reservation.dart';
import 'package:flutter_login/regions.dart';
import 'package:get/get.dart';

class RegionReservation extends StatelessWidget {
  final String email;
  const RegionReservation({Key? key, required this.email}) : super(key: key);

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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('img/face_image.PNG'),
                  backgroundColor: Colors.white,
                ),
                accountName: Text(
                  'NAME',
                  style: TextStyle(color: Colors.black),
                ),
                accountEmail: Text(
                  AuthController.instance.auth.currentUser!.email!,
                  style: TextStyle(color: Colors.black),
                ),
                decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0))),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Get.to(MainHome(email: email));
                  print("홈버튼!!!!");
                },
              ),
              ListTile(
                  leading: Icon(Icons.person),
                  title: Text('MyProfile'),
                  onTap: () {
                    print('profile is clicked');
                    Get.to(MyProfile(email: email));
                  }),
              ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Setting'),
                  onTap: () {
                    print('Setting is clicked');
                  }),
              ListTile(
                  leading: Icon(Icons.question_answer_outlined),
                  title: Text('Q&A'),
                  onTap: () {
                    print('Q&A is clicked');
                  }),
              ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    print('로그아웃');
                    AuthController.instance.logOut();
                  })
            ], //Home, MyProfile, Setting, Q&A, Logout
          ),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 3),
              ),
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: Text(
                        'Standard Room',
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ),
                  Image(
                    image: AssetImage("img/room_img/Single.PNG"),
                  ),
                  Container(
                    child: Text('Hello'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Image(image: AssetImage("img/room_img/Deluxe.PNG")),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Image(image: AssetImage("img/room_img/Executive.PNG")),
            ),
            SizedBox(height: 10.0),
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
