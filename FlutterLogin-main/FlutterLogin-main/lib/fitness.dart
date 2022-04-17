import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:get/get.dart';
import '../fireStore.dart' as dbName;
import '../payment.dart';
import 'announcement.dart';
import 'mainHome.dart';
import 'myProfile.dart';
import 'myProfileNotReservation.dart';
import 'auth_controller.dart';

class Fitness extends StatefulWidget {
  const Fitness({Key? key}) : super(key: key);

  @override
  State<Fitness> createState() => _FitnessState();
}

class _FitnessState extends State<Fitness> {
  @override
  final List<String> imgList = [
    "img/fitnessDetail/fitness_detail1.PNG",
    "img/fitnessDetail/fitness_detail2.PNG",
    "img/fitnessDetail/fitness_detail3.PNG",
    "img/fitnessDetail/fitness_detail4.PNG",
  ];
  final PageController _controller = PageController(initialPage: 0);

  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[400],
          title: Text(
            "Fitness Center",
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
          padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 10.0,
            ),
            Container(
              // height: size.height / 2,
              // width: size.width,
              child: CarouselSlider.builder(
                itemBuilder: (BuildContext context, int index, int realIndex) =>
                    Container(
                  child: InkWell(
                    onTap: () {
                      print("${index}눌림!!");
                    },
                    child: Image.asset(
                      imgList[index],
                      // width: size.width,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true, //이미지 가운데 정확히 맞추기
                  autoPlayAnimationDuration: Duration(seconds: 4),
                ),
                itemCount: imgList.length,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TUK호텔 최고의 피트니스 클럽",
                  style: TextStyle(
                      color: Colors.brown[300],
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey, // Background color
                    ),
                    onPressed: () {
                      Get.to(Payment(
                        email: AuthController.instance.auth.currentUser!.email!,
                      ));
                    },
                    child: Text("이용 등록",
                        style: TextStyle(fontWeight: FontWeight.bold)))
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
                "체계적인 체력 관리를 위한 기능별 공간과 최상의 휴식을 위한 공간으로 조성되어 운동과 휴식을 조화롭게 즐기실 수 있는 실내 체육관 입니다."),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Text(
                  "운영시간 ",
                  style: TextStyle(color: Colors.brown[300], fontSize: 14.0),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text("05:30 ~ 22:30 "),
                SizedBox(
                  width: 20.0,
                ),
                
              ],
            ),
            Row(
              children:[
                Text(
                  "대여 품목 ",
                  style: TextStyle(color: Colors.brown[300], fontSize: 14.0),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text("트레이닝 복(무료), 양말(무료)")
              ]
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
                "- 체육관은 만 16세 이상 고객에 한해 입장 가능합니다.\n- 고객 여러분의 안전을 위하여 음주 후 체육관, 사우나, 실내 수영장 등의 피트니스 시설 이용은 제한될 수 있습니다.\n- 실내 체육관 입장 시 반드시 운동복과 실내용 운동화를 착용해 주시기 바랍니다.\n- 코로나19 확산 방지를 위해 운동화 대여 서비스를 제공하지 않습니다. 양해 부탁드립니다."),
            
          ]),
        ),
      ),
    );
  }
}
