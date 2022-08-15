// ignore_for_file: unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/mainHome.dart';
import 'package:flutter_login/widget/appbar_widget.dart';
import 'mainHomeNotReservation.dart';
import 'fireStore.dart' as dbName;

class ReservationCancel extends StatelessWidget {
  const ReservationCancel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _emailController = TextEditingController();
    var _phoneController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 39, 52, 80),
          title: Text(
            "Reservation Cancel",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          elevation: 0.0, //앱바의 입체감을 없애주기위함
          centerTitle: true,
        ),
        drawer: DrawerArea(
          drawerAread: Drawer(),
        ),
        body: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "취소할 사용자 이메일",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.account_circle_rounded,
                  color: Colors.blue[100],
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
              ),
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                hintText: "취소할 사용자 핸드폰 번호",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.account_circle_rounded,
                  color: Colors.blue[100],
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
              ),
            ),
            OutlinedButton(
              child: Text("예약 취소"),
              onPressed: () {
                var email = _emailController.text;
                var phone = _phoneController.text;
                var room;
                FirebaseFirestore.instance
                    .collection("member")
                    .doc("${email}")
                    .get()
                    .then((value) {
                  if (phone == value.data()?["phone"]) {
                    print("ok");
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                                title: Text("예약 내역"),
                                content: Text(
                                  "\n\n 정말 취소하시겠습니까?",
                                  style: TextStyle(fontSize: 15.0),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        FirebaseFirestore.instance
                                            .collection("hotel")
                                            .doc("${dbName.userRoom}")
                                            .update({
                                          "Registered": false,
                                          "checkInDay": 0,
                                          "checkInMonth": 0,
                                          "checkInYear": 0,
                                          "checkOutDay": 0,
                                          "checkOutMonth": 0,
                                          "checkOutYear": 0,
                                        });

                                        FirebaseFirestore.instance
                                            .collection("member")
                                            .doc("${email}")
                                            .update({
                                          "reservation": false,
                                          "rooms": FieldValue.delete(),
                                        });
                                      },
                                      child: Text("Yes")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Close"))
                                ]));
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                                content: Text(
                                  "존재하지 않는 예약자입니다.",
                                  style: TextStyle(fontSize: 15.0),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Close"))
                                ]));
                  }
                });
              },
            )
          ],
        ));
  }
}
