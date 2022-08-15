import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login/auth_controller.dart';

// 컬렉션 필드값 읽기

//전역변수 사용
var userName = "";
var userPhone = "";
var userReservation = false;
var checkInTime = "";
var checkOutTime = "";
var checkInDay = "";
var checkOutDay = "";
var userRoom = ""; //선택한 방
var cost = 0;
var order = false;

void initState() async {
  //userDB 이름 조회 후 변수값에 저장
  FirebaseFirestore.instance
      .collection("member")
      .doc("${AuthController.instance.auth.currentUser!.email}")
      .get()
      .then((value) {
    print("@@" + value.data()?["name"]);
    userName = value.data()?["name"];
  });

// UserDB 핸드폰 번호 조회
  FirebaseFirestore.instance
      .collection('member')
      .doc("${AuthController.instance.auth.currentUser!.email}")
      .get()
      .then((value) {
    userPhone = value.data()?["phone"];
  });

//UserDB 예약 여부 조회
  FirebaseFirestore.instance
      .collection('member')
      .doc("${AuthController.instance.auth.currentUser!.email}")
      .get()
      .then((value) {
    userReservation = value.data()?["reservation"];
  });

//UserDB 선택한 Rooms 조회
  await FirebaseFirestore.instance
      .collection('member')
      .doc("${AuthController.instance.auth.currentUser!.email}")
      .get()
      .then((value) {
    userRoom = value.data()?["rooms"];
  });

  //order 변경
  await FirebaseFirestore.instance
      .collection('order')
      .doc("raspberrypi")
      .get()
      .then((value) {
    order = value.data()?["order"];
  });

  //체크인 시간 확인
  await FirebaseFirestore.instance
      .collection('hotel')
      .doc("${userRoom}")
      .get()
      .then((value) {
    checkInTime = value.data()?["CheckIn"];
  });

  await FirebaseFirestore.instance
      .collection('hotel')
      .doc("${userRoom}")
      .get()
      .then((value) {
    checkOutTime = value.data()?["CheckOut"];
  });

  await FirebaseFirestore.instance
      .collection('hotel')
      .doc("${userRoom}")
      .get()
      .then((value) {
    var outday = value.data()?["checkOutDay"];
    var outmonth = value.data()?["checkOutMonth"];
    checkOutDay = outmonth.toString() + "-" + outday.toString();
  });

  await FirebaseFirestore.instance
      .collection('hotel')
      .doc("${userRoom}")
      .get()
      .then((value) {
    var inday = value.data()?["checkInDay"];
    var inmonth = value.data()?["checkInMonth"];
    checkInDay = inmonth.toString() + "-" + inday.toString();
  });

  await FirebaseFirestore.instance
      .collection('hotel')
      .doc("${userRoom}")
      .get()
      .then((value) {
    cost = value.data()?["cost"];
  });
}

void readData() {
  String userName = "";

  Map userData = {};

  final userCollectionReference = FirebaseFirestore.instance
      .collection("member")
      .doc("${AuthController.instance.auth.currentUser!.email!}");

  // userCollectionReference
  //     .get()
  //     .then((value) => {(name2 = value.data()?['name'])});

  // await userCollectionReference.get().then((value) => {
  //       //값을 읽으면서, 그 값을 변수로 넣는 부분
  //       name2 = value['name'],
  //       // print(name2),
  //     });

  // await FirebaseFirestore.instance
  //     .collection('member')
  //     .doc("hae8064@tukorea.ac.kr")
  //     .get()
  //     .then((QuerySnapshot querySnapshot) => {
  //           querySnapshot.docs.forEach((doc) {
  //             _testResult.add(doc.data());
  //           })
  //         });

  // print("@@@@@이름 ${userName}");
}

class UserDB {
  String userName = "";
  bool reservation = false;

  UserDB({
    required this.userName,
    required this.reservation,
  });

  void readDataName() {
    FirebaseFirestore.instance
        .collection("member")
        .doc("${AuthController.instance.auth.currentUser!.email}")
        .get()
        .then((value) {
      // print(value.data()?["name"]);
      userName = value.data()!["name"];
      return userName;
    });
  }
}

class UserManager {
  late UserDB _userDB;
  UserDB get user => _userDB;
}
