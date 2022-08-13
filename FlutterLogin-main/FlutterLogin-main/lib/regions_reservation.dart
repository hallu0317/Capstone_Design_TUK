// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/detail/deluxDetail.dart';
import 'package:flutter_login/detail/executiveDetail.dart';
import 'package:flutter_login/detail/standardDetail.dart';
import 'package:flutter_login/detail/superiorDetail.dart';
import 'package:flutter_login/fireStore.dart' as dbName;
import 'package:flutter_login/mainHome.dart';
import 'package:flutter_login/myProfile.dart';
import 'package:flutter_login/myProfileNotReservation.dart';
import 'widget/appbar_widget.dart';
import 'package:get/get.dart';

import 'announcement.dart';

class Reservation extends StatefulWidget {
  final String email;
  const Reservation({Key? key, required this.email}) : super(key: key);

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  var choiceRoom = ""; //선택 된 방
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RegionReservation',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 39, 52, 80),
          title: Text(
            "Room Reservation",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          elevation: 0.0, //앱바의 입체감을 없애주기위함
          centerTitle: true,
        ),
        drawer: DrawerArea(
          drawerAread: Drawer(),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
              ),
              child: Column(
                children: [
                  Container(
                    child: Text(
                      'Standard Room',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0),
                    ),
                  ),
                  Image(
                    image: AssetImage("img/room_img/Single.PNG"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('스탠다드',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0,
                                    color: Colors.grey[600])),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey, // Background color
                              ),
                              // style: ButtonStyle(backgroundColor: Colors.accents),
                              onPressed: () async {
                                choiceRoom = "Standard";
                                updateMemberData();
                                dbName.initState();
                                await Get.to(() => StandardDetail());
                              },
                              child: Text(
                                "예약하기",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Text('아늑하면서 효율적인 공간',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                color: Colors.grey[600])),
                        SizedBox(height: 10.0),
                        Text('침대타입 : 더블(킹 사이즈), 트윈',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                color: Colors.grey[600])),
                        Text('객실크기 : 36m²',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                color: Colors.grey[600]))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
              ),
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: Text(
                        'Deluxe Room',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0),
                      ),
                    ),
                  ),
                  Image(image: AssetImage("img/room_img/Deluxe.PNG")),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('디럭스',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0,
                                    color: Colors.grey[600])),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey, // Background color
                              ),
                              // style: ButtonStyle(backgroundColor: Colors.accents),
                              onPressed: () async {
                                choiceRoom = "Deluxe";
                                updateMemberData();
                                dbName.initState();
                                await Get.to(() => DeluxDetail());
                              },
                              child: Text(
                                "예약하기",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Text('여유로운 휴식을 위한 공간',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                color: Colors.grey[600])),
                        SizedBox(height: 10.0),
                        Text('침대타입 : 더블(킹 사이즈)',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                color: Colors.grey[600])),
                        Text('객실크기 : 51m²',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                color: Colors.grey[600]))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
              ),
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: Text(
                        'Executive Room',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0),
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {},
                      child: Image(
                          image: AssetImage("img/room_img/Executive.PNG"))),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('이그제큐티브',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0,
                                    color: Colors.grey[600])),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey, // Background color
                              ),
                              // style: ButtonStyle(backgroundColor: Colors.accents),
                              onPressed: () async {
                                choiceRoom = "Executive";
                                await updateMemberData();
                                dbName.initState();
                                Get.to(() => ExecutiveDetail());
                              },
                              child: Text(
                                "예약하기",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Text('휴식이 필요한 비즈니스 고객을 위한 공간',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                color: Colors.grey[600])),
                        SizedBox(height: 10.0),
                        Text('침대타입 : 더블(킹 사이즈), 트윈',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                color: Colors.grey[600])),
                        Text('객실크기 : 43m²',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                color: Colors.grey[600]))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
              ),
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: Text(
                        'Suite Room',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0),
                      ),
                    ),
                  ),
                  Image(image: AssetImage("img/room_img/Suite.PNG")),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('스위트',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0,
                                    color: Colors.grey[600])),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey, // Background color
                              ),
                              // style: ButtonStyle(backgroundColor: Colors.accents),
                              onPressed: () async {
                                choiceRoom = "Superior";
                                await updateMemberData();
                                dbName.initState();
                                Get.to(() => SuperiorDetail());
                              },
                              child: Text(
                                "예약하기",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Text('모던한 분위기의 고급스러운 공간',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                color: Colors.grey[600])),
                        SizedBox(height: 10.0),
                        Text('침대타입 : 더블(킹 사이즈), 트윈',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                color: Colors.grey[600])),
                        Text('객실크기 : 124m²',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                color: Colors.grey[600]))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  final memberCollection = FirebaseFirestore.instance.collection("member");
//회원가입 데이터 디비 저장
  Future updateMemberData() async {
    print("@@rooms 필드 값 변경!!");
    return await memberCollection
        .doc(AuthController.instance.auth.currentUser!.email!)
        .update({
      "rooms": choiceRoom,
    });
  }
}
