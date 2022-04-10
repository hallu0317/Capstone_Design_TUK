// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/detail/standardDetail.dart';
import 'package:flutter_login/fireStore.dart';
import 'package:flutter_login/mainHome.dart';
import 'package:flutter_login/myProfileNotReservation.dart';
import 'package:flutter_login/regions_reservation.dart';
import 'package:flutter_login/regions.dart';
import 'package:get/get.dart';

class Reservation extends StatefulWidget {
  final String email;
  const Reservation({Key? key, required this.email}) : super(key: key);

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  var choiceRoom = ""; //선택 된 방

  DateTime _selectedDate_in = DateTime.now();
  DateTime _selectedDate_out = DateTime.now();
  @override
  Widget build(BuildContext context) {
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
                  Get.to(MainHome(email: widget.email));
                  print("홈버튼!!!!");
                },
              ),
              ListTile(
                  leading: Icon(Icons.person),
                  title: Text('MyProfile'),
                  onTap: () {
                    print('profile is clicked');
                    Get.to(MyProfileNotReservation(email: widget.email));
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
          child: Column(children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          child: Text(
                            "Check In",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Future<DateTime?> selected_in = showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate:
                                    DateTime.now().add(Duration(days: 365)),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                      data: ThemeData.light(), child: child!);
                                });
                            selected_in.then((selected_in) {
                              setState(() {
                                _selectedDate_in = selected_in!;
                              });
                            });
                          }),
                      SizedBox(
                        width: 60.0,
                      ),
                      OutlinedButton(
                          child: Text(
                            "Check Out",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Future<DateTime?> selected_out = showDatePicker(
                                context: context,
                                initialDate:
                                    _selectedDate_in.add(Duration(days: 1)),
                                firstDate:
                                    _selectedDate_in.add(Duration(days: 1)),
                                lastDate:
                                    DateTime.now().add(Duration(days: 366)),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                      data: ThemeData.light(), child: child!);
                                });
                            selected_out.then((selected_out) {
                              setState(() {
                                _selectedDate_out = selected_out!;
                              });
                            });
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_selectedDate_in.month.toString().padLeft(2, '0')}-${_selectedDate_in.day.toString().padLeft(2, '0')}',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[500]),
                      ),
                      SizedBox(
                        width: 25.0,
                      ),
                      Text(
                        "~",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[500]),
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      Text(
                        '${_selectedDate_out.month.toString().padLeft(2, '0')}-${(_selectedDate_out.day + 1).toString().padLeft(2, '0')}',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[500]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
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
                              onPressed: () {
                                choiceRoom = "스탠다드(Standard)";
                                updateMemberData();
                                Get.to(() => StandardDetail());
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
                              onPressed: () {
                                choiceRoom = "디럭스(Deluxe)";
                                updateMemberData();
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
                              onPressed: () {
                                choiceRoom = "이그제큐티브(Executive)";
                                updateMemberData();
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
                              onPressed: () {
                                choiceRoom = "슈페리어(Superior)";
                                updateMemberData();
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
            )
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
