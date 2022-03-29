import 'package:flutter/material.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/fireStore.dart' as dbName;
import 'package:flutter_login/mainHome.dart';
import 'package:get/get.dart';

class MyProfileNotReservation extends StatelessWidget {
  final String email;
  MyProfileNotReservation({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyle(fontSize: 20.0),
        ),
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
                  Get.to(MyProfileNotReservation(
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
          // Center(
          //   child: Text(
          //     "$email님 환영합니다.",
          //     style: TextStyle(fontSize: 20.0),
          //   ),
          // ),
          Container(
            height: 180,
            color: Colors.blue[200],
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: AssetImage('img/face_image.PNG'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
