import 'package:flutter/material.dart';
import 'package:flutter_login/announcement.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/fireStore.dart' as dbName;
import 'package:flutter_login/mainHome.dart';
import 'package:flutter_login/myProfile.dart';
import 'package:flutter_login/myProfileNotReservation.dart';
import 'package:get/get.dart';

class DrawerArea extends StatefulWidget implements PreferredSizeWidget {
  final Drawer drawerAread;

  const DrawerArea({Key? key, required this.drawerAread}) : super(key: key);

  @override
  State<DrawerArea> createState() => _DrawerAreaState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _DrawerAreaState extends State<DrawerArea> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              print(dbName.userReservation);
              Route route = MaterialPageRoute(
                  builder: (context) => MainHome(
                      email: AuthController.instance.auth.currentUser!.email!));
              Navigator.pushReplacement(context, route);
            },
          ),
          ListTile(
              leading: Icon(Icons.person),
              title: Text('MyProfile'),
              onTap: () {
                if (dbName.userReservation == true) {
                  print('profile is clicked');
                  Get.to(MyProfile(
                      email: AuthController.instance.auth.currentUser!.email!));
                } else {
                  Get.to(MyProfileNotReservation(
                      email: AuthController.instance.auth.currentUser!.email!));
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
    );
  }
}
