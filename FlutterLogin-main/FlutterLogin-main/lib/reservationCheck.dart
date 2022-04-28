import 'package:flutter/material.dart';
import 'package:flutter_login/announcement.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/myProfile.dart';
import 'package:flutter_login/myProfileNotReservation.dart';
import 'package:flutter_login/swimming.dart';
import 'package:get/get.dart';
import 'fireStore.dart' as dbName;
import 'mainHome.dart';
import 'fitness.dart';
import 'restaurant.dart';

class reservationCheck extends StatelessWidget {
  const reservationCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[400],
          title: Text(
            "Reservation Check",
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
                    if (dbName.userReservation == true) {
                      print('profile is clicked');
                      Get.to(MyProfile(
                          email: AuthController
                              .instance.auth.currentUser!.email!));
                    } else {
                      Get.to(MyProfileNotReservation(
                          email: AuthController
                              .instance.auth.currentUser!.email!));
                    }
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
            ],
            //Home, MyProfile, Setting, Q&A, Logout
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const Image(
              image: AssetImage("img/room_img/Single.PNG"),
            ),
            const Text(
              "예약자 정보",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            Text(
              "이름 ${dbName.userName}\n"
              "전화번호 ${dbName.userPhone}\n"
              "이메일 ${AuthController.instance.auth.currentUser!.email!}",
              style: TextStyle(fontSize: 15.0),
            ),
            Text(
              "예약 내역",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            Text(
              "TUK 호텔 ${dbName.userRoom}\n"
              "체크인/체크아웃 시간 : 15:00 ~ 12:00",
              style: TextStyle(fontSize: 15.0),
            ),
            Text(
              "결제 내역",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ],
        )),
      ),
    );
  }
}
