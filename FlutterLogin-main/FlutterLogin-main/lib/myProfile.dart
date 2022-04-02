// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/fireStore.dart' as dbName;
import 'package:flutter_login/mainHome.dart';
import 'package:get/get.dart';
import 'regions_reservation.dart';

class MyProfile extends StatelessWidget {
  final String email;
  MyProfile({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Text(
          "My Profile",
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
      body: Column(
        children: [
          Container(
            height: 200.0,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue[100],
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: AssetImage('img/face_image.PNG'),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  AuthController.instance.auth.currentUser!.email!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Text(
                  "TUK HOTEL",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        children: [
                          Text(
                            "Check In",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "15:00",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        children: [
                          Text(
                            "Check Out",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "11:00",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Divider(
            thickness: 2.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 40.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      dbName.userName,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    )
                  ],
                ),
                Divider(
                  thickness: 2.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.call,
                      size: 40.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      dbName.userPhone,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    )
                  ],
                ),
                Divider(
                  thickness: 2.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.lock,
                      size: 40.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "비밀번호 변경",
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
