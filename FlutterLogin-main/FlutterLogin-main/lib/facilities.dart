import 'package:flutter/material.dart';
import 'package:flutter_login/announcement.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/myProfile.dart';
import 'package:flutter_login/myProfileNotReservation.dart';
import 'package:get/get.dart';
import 'fireStore.dart' as dbName;
import 'mainHome.dart';

class Facilities extends StatelessWidget {
  const Facilities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[400],
          title: Text(
            "TUK-Capstone",
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
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'INFINITY POOL',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3.0,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Image(
                      image: AssetImage("img/facility/swimming_pool.PNG"),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('사계절 이용 가능 풀',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                      color: Colors.black87)),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey, // Background color
                                ),
                                // style: ButtonStyle(backgroundColor: Colors.accents),
                                onPressed: () async {},
                                child: Text(
                                  "자세히 보기",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Text('TKU호텔의 사계절을 즐기는 쉼의 공간',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0,
                                  color: Colors.grey[600])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'FITNESS',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3.0,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Image(
                      image: AssetImage("img/facility/fitness.PNG"),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('24시간 운영 FITNESS CENTER',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                      color: Colors.black87)),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey, // Background color
                                ),
                                // style: ButtonStyle(backgroundColor: Colors.accents),
                                onPressed: () async {},
                                child: Text(
                                  "자세히 보기",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Text('휴식과 건강을 한번에',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0,
                                  color: Colors.grey[600])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'RESTAURANT',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3.0,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Image(
                      image: AssetImage("img/facility/restaurant.PNG"),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('TUK호텔 뷔페',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                      color: Colors.black87)),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey, // Background color
                                ),
                                // style: ButtonStyle(backgroundColor: Colors.accents),
                                onPressed: () async {},
                                child: Text(
                                  "자세히 보기",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Text('TUK호텔에서 제공하는 최고의 식사',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0,
                                  color: Colors.grey[600])),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
