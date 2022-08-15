// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/add_auth.dart';
import 'package:flutter_login/announcement.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/fireStore.dart' as dbName;
import 'package:flutter_login/mainHomeNotReservation.dart';
import 'package:flutter_login/myProfileNotReservation.dart';
import 'package:flutter_login/payment.dart';
import 'package:flutter_login/regions_reservation.dart';
import 'package:flutter_login/regions.dart';
import 'package:flutter_login/reservationAlert.dart';
import 'package:get/get.dart';
import 'myProfile.dart';
import 'package:flutter_login/facilities.dart';
import 'package:flutter_login/reservationCheck.dart';
import 'add_auth.dart';
import 'reservationCancel.dart';
import 'widget/appbar_widget.dart';

//MainHome화면
class MainHome extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey(); //Drawer적용시키기 위함
  //로그인한 이메일
  final String email;
  MainHome({Key? key, required this.email}) : super(key: key);
  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    if (dbName.userReservation == false) {
      return mainHome2();
    } else {
      fireStoreReadName();
      dbName.initState();
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 39, 52, 80),
            title: Text(
              "TUK-Capstone",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                  height: 30.0,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 350,
                        height: 340,
                        padding: const EdgeInsets.all(20.0),
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey[300]),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Column(
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  "img/mainHotelImg.jpg",
                                  width: 150,
                                  height: 140,
                                ),
                              ),
                              Text(
                                "TUK Hotel - ${dbName.userRoom}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                "체크인: 15:00",
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.grey),
                              ),
                              Text(
                                "체크아웃: 12:00",
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.grey),
                              ),
                              Spacer(), //버튼 하단 배치
                              IconButton(
                                onPressed: () {
                                  print("Open!!");
                                  updateOrderData();
                                  updateMemberData();
                                  updateRoomData();
                                  print(dbName.userName);
                                },
                                icon: Icon(Icons.lock_open),
                                iconSize: 60.0,
                                color: Colors.yellow[700],
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
                    children: [],
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
                                      Get.to(Reservation(email: widget.email));
                                    } else if (regions[index] == "예약 조회") {
                                      Get.to(reservationCheck());
                                      print("예약 조회 클릭");
                                    } else if (regions[index] == "시설 이용") {
                                      Get.to(Facilities());
                                      print("시설 이용 클릭");
                                    } else if (regions[index] == "사용자 추가") {
                                      Get.to(AddAuth());
                                      print("사용자 추가 클릭");
                                    } else if (regions[index] == "예약 취소") {
                                      Get.to(ReservationCancel());
                                      print("예약 취소 클릭");
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
  }

  void fireStoreReadName() {
    FirebaseFirestore.instance
        .collection("member")
        .doc("${AuthController.instance.auth.currentUser!.email}")
        .get()
        .then((value) {
      print(value.data()?["name"]);
      name = value.data()?["name"];
    });
  }

  final orderCollection = FirebaseFirestore.instance.collection("order");
//도어락 오픈시 order 필드 값 true변경
  Future updateOrderData() async {
    print("@@order 필드 값 변경!!");
    return await orderCollection.doc("raspberrypi").update({
      "order": true,
    });
  }

  final memberCollection = FirebaseFirestore.instance.collection("order");
//도어락 open시 member필드에 이메일 값 저장
  Future updateMemberData() async {
    print("@@order member필드값 변경!");
    return await memberCollection.doc("raspberrypi").update({
      "member": AuthController.instance.auth.currentUser!.email,
    });
  }

  final roomCollection = FirebaseFirestore.instance.collection("order");
//도어락 open시 member필드에 이메일 값 저장
  Future updateRoomData() async {
    print("@@order member필드값 변경!");
    return await roomCollection.doc("raspberrypi").update({
      "roomtype": dbName.userRoom,
    });
  }
}
