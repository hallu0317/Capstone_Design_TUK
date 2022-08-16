import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/announcement.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/myProfile.dart';
import 'package:flutter_login/myProfileNotReservation.dart';
import 'package:get/get.dart';
import 'fireStore.dart' as dbName;
import 'mainHome.dart';
import 'widget/appbar_widget.dart';
import 'regions_reservation.dart';
import 'facilities.dart';

Widget mainHome2() {
  var regions = ["예약", "시설 목록"];
  dbName.initState();
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 39, 52, 80),
        title: Text(
          "TUK-Capstone",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevation: 0.0, //앱바의 입체감을 없애주기위함
        centerTitle: true,
      ),
      drawer: DrawerArea(
        drawerAread: Drawer(),
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
                    height: 340,
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
                                } else if (regions[index] == "시설 목록") {
                                  Get.to(Facilities());
                                  print("시설 목록 클릭");
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
