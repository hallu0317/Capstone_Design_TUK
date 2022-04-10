import 'package:flutter/material.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/fireStore.dart' as dbName;
import 'package:flutter_login/mainHome.dart';
import 'package:get/get.dart';

import 'myProfile.dart';

class Announcement extends StatelessWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Text(
          "AnnounceMent",
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
          ],
          //Home, MyProfile, Setting, Q&A, Logout
        ),
      ),
      body: Column(children: [
        TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text("앱 사용법 안내"),
                    content: new Text("1. 회원가입 진행"),
                    actions: [
                      new TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Close"))
                    ],
                  );
                },
              );
            },
            child: Text(
              "1. 앱 사용법",
              style: TextStyle(
                  color: Colors.blue[300],
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )),
        Divider(
          thickness: 1,
          color: Colors.black,
        ),
        TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text("앱 사용법 안내"),
                    content: new Text("1. 회원가입 진행"),
                    actions: [
                      new TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Close"))
                    ],
                  );
                },
              );
            },
            child: Text(
              "2. 호텔 이용시 유의 사항",
              style: TextStyle(
                  color: Colors.blue[300],
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )),
        Divider(
          thickness: 1,
          color: Colors.black,
        ),
        TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text("앱 사용법 안내"),
                    content: new Text("1. 회원가입 진행"),
                    actions: [
                      new TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Close"))
                    ],
                  );
                },
              );
            },
            child: Text(
              "3. 버전 정보",
              style: TextStyle(
                  color: Colors.blue[300],
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )),
        Divider(
          thickness: 1,
          color: Colors.black,
        ),
      ]),
    );
  }
}
