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
                "전 연령 고객이 입장 가능한 풀로 실내, 외 수영장이 연결되어 편리하고 여유롭게 이용하실 수 있으며 밤이되면 따뜻한 온수풀에서 밤하늘을 \n감상할 수 있습니다."),
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
                Text("09:00 ~ 24:00 "),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  "이용대상 ",
                  style: TextStyle(color: Colors.brown[300], fontSize: 14.0),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text("투숙객")
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text("운영 방침: "),
            Text(
                "- 적정인원을 초과 시 입장이 제한될 수 있습니다.\n- 모든 지역은 금연 구역입니다.\n- 귀중품은 반드시 개인 락커룸에 보관해 주시고, 분실되지 않도록 유의 바랍니다.\n- 체크아웃 당일에는 15시까지 이용 가능하며, 이용을 원하실 경우 13시 전에 입장하여 주시기 바랍니다.\n"),
            Text("에티켓: "),
            Text(
                "- 깨끗한 수질 관리를 위하여 샤워 후 입수 바라며, 입수 시 수영모를 착용해 주시기 바랍니다.\n- 선탠 오일 등의 태닝 제품을 바르신 경우, 클렌징(Cleansing) 후 이용해 주시기 바랍니다.\n- 수영장을 이용하는 주변 고객에게 불편을 주는 행위는 삼가 주시기 바랍니다.\n"),
          ]),
        ),
      ),
    );
  }
}
