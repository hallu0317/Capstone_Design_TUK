import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login/auth_controller.dart';

// 컬렉션 필드값 읽기
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

  FirebaseFirestore.instance
      .collection("member")
      .doc("${AuthController.instance.auth.currentUser!.email}")
      .get()
      .then((value) {
    // print(value.data()?["name"]);
    userName = value.data()?["name"];
  });
  // print("@@@@@이름 ${userName}");
}
