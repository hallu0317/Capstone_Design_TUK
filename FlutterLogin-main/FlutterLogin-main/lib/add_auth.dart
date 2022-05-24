// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/announcement.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/fireStore.dart' as dbName;
import 'package:flutter_login/mainHome.dart';
import 'package:flutter_login/myProfile.dart';
import 'package:get/get.dart';

class AddAuth extends StatelessWidget {
  const AddAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _emailController = TextEditingController();
    var _phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Text(
          "Add_Auth",
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
                // dbName.userName,
                dbName.userName,
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
                print("홈버튼!!!!");
                Get.to(MainHome(
                    email: AuthController.instance.auth.currentUser!.email!));
              },
            ),
            ListTile(
                leading: Icon(Icons.person),
                title: Text('MyProfile'),
                onTap: () {
                  print('profile is clicked');
                  Get.to(MyProfile(
                      email: AuthController.instance.auth.currentUser!.email!));
                }),
            ListTile(
                leading: Icon(Icons.settings),
                title: Text('Setting'),
                onTap: () {
                  print('Setting is clicked');
                }),
            ListTile(
                leading: Icon(Icons.announcement),
                title: Text('announcement'),
                onTap: () {
                  Get.to(Announcement());
                  print('announcement is clicked');
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
