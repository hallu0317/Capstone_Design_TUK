import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/myProfileNotReservation.dart';
import 'package:get/get.dart';
import 'fireStore.dart' as dbName;
import 'mainHome.dart';
import 'payment.dart';
import 'regions.dart';
import 'regions_reservation.dart';

Widget mainHome2() {
  dbName.initState();
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Text(
          "TUK-Capstone",
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
                "${dbName.userName}",
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
                Get.to(MainHome(
                    email: AuthController.instance.auth.currentUser!.email!));
                print("홈버튼!!!! ${dbName.userName}");
              },
            ),
            ListTile(
                leading: Icon(Icons.person),
                title: Text('MyProfile'),
                onTap: () {
                  print('profile is clicked');
                  Get.to(MyProfileNotReservation(
                      email: AuthController.instance.auth.currentUser!.email!));
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
          ],
          //Home, MyProfile, Setting, Q&A, Logout
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 350,
                    height: 350,
                    padding: const EdgeInsets.all(20.0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[350],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "예약된 호텔 정보가 없습니다.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(Reservation(
                                  email: AuthController
                                      .instance.auth.currentUser!.email!));
                            },
                            child: Text(
                              "호텔 예약 하러가기",
                              style:
                                  TextStyle(fontSize: 14.0, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "예약 지역 선택",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            GridView.builder(
              itemCount: regions.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Flexible(
                  child: Card(
                    child: Container(
                      child: Center(
                          child: TextButton(
                              onPressed: () {
                                if (regions[index] == "예약") {
                                  Get.to(Reservation(
                                      email: AuthController
                                          .instance.auth.currentUser!.email!));
                                } else if (regions[index] == "예약 조회") {
                                  print("예약 조회 클릭");
                                } else if (regions[index] == "시설 이용") {
                                  Get.to(Payment(
                                      email: AuthController
                                          .instance.auth.currentUser!.email!));
                                  print("시설 이용 클릭");
                                }
                              },
                              child: Text(
                                regions[index],
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ))),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
