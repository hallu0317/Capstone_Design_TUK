// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/announcement.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/fireStore.dart' as dbName;
import 'package:flutter_login/mainHome.dart';
import 'package:flutter_login/myProfile.dart';
import 'package:get/get.dart';
import 'widget/appbar_widget.dart';

class AddAuth extends StatelessWidget {
  const AddAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _emailController = TextEditingController();
    var _phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 39, 52, 80),
        title: Text(
          "Add_Auth",
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
              hintText: "추가할 사용자 이메일",
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
              hintText: "추가할 사용자 핸드폰 번호",
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
              onPressed: () {
                var email = _emailController.text;
                var phone = _phoneController.text;
                FirebaseFirestore.instance
                    .collection("member")
                    .doc("${email}")
                    .get()
                    .then((value) {
                  if (phone == value.data()?["phone"]) {
                    print("OK");
                    FirebaseFirestore.instance
                        .collection("member")
                        .doc("${email}")
                        .update({
                      "reservation": true,
                      "rooms": dbName.userRoom,
                    });
                  } else {
                    print("No Exist");
                  }
                  ;
                });
              },
              child: Text("사용자 추가"))
        ],
      ),
    );
  }
}
