import 'package:flutter/material.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/fireStore.dart';
import 'package:flutter_login/myProfile.dart';
import 'package:flutter_login/regions.dart';
import 'package:get/get.dart';

//MainHome화면
class MainHome extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey(); //Drawer적용시키기 위함
  //로그인한 이메일
  String email;
  MainHome({Key? key, required this.email}) : super(key: key);
  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "TUK-Capstone",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          elevation: 0.0, //앱바의 입체감을 없애주기위함
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
        drawer: drawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 350,
                      height: 350,
                      padding: const EdgeInsets.all(20.0),
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[350],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                "img/mainHotelImg.jpg",
                                width: 150,
                                height: 140,
                              ),
                            ),
                            Text(
                              "TUK Hotel - 707호",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "체크인: 15:00",
                              style:
                                  TextStyle(fontSize: 15.0, color: Colors.grey),
                            ),
                            Text(
                              "체크아웃: 12:00",
                              style:
                                  TextStyle(fontSize: 15.0, color: Colors.grey),
                            ),
                            Spacer(), //버튼 하단 배치
                            IconButton(
                              onPressed: () {
                                print("Open!!");
                                readData();
                              },
                              icon: Icon(Icons.lock_open),
                              iconSize: 60.0,
                              color: Colors.yellow[700],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "예약 지역 선택",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              GridView.builder(
                itemCount: regions.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Flexible(
                    child: Card(
                      child: Container(
                        child: Center(child: Text(regions[index])),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

//슬라이드 메뉴바
  Drawer drawer() {
    return Drawer(
        child: ListView(
      children: [
        ListTile(
          leading: Icon(
            Icons.home,
            color: Colors.grey[850],
          ),
          title: Text("Home"),
          onTap: () {
            Get.to(MainHome(email: widget.email));
            print("홈버튼!!!!");
          },
          trailing: Icon(Icons.add),
        ),
        ListTile(
          leading: Icon(
            Icons.person,
            color: Colors.grey[850],
          ),
          title: Text('My Profile'),
          onTap: () {
            print('profile is clicked');
            Get.to(MyProfile(email: widget.email));
          },
          trailing: Icon(Icons.add),
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            color: Colors.grey[850],
          ),
          title: Text('Setting'),
          onTap: () {
            print('Setting is clicked');
          },
          trailing: Icon(Icons.add),
        ),
        ListTile(
          leading: Icon(
            Icons.question_answer,
            color: Colors.grey[850],
          ),
          title: Text('Q&A'),
          onTap: () {
            print('Q&A is clicked');
          },
          trailing: Icon(Icons.add),
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Colors.grey[850],
          ),
          title: Text('Logout'),
          onTap: () {
            print('로그아웃');
            AuthController.instance.logOut();
          },
          trailing: Icon(Icons.add),
        ),
      ],
    ));
  }
}
