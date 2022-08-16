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
import 'widget/appbar_widget.dart';

class Restaurant extends StatefulWidget {
  const Restaurant({Key? key}) : super(key: key);

  @override
  State<Restaurant> createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  @override
  final List<String> imgList = [
    "img/restaurantDetail/restaurant_detail1.PNG",
    "img/restaurantDetail/restaurant_detail2.PNG",
    "img/restaurantDetail/restaurant_detail3.PNG",
    "img/restaurantDetail/restaurant_detail4.PNG",
  ];
  final PageController _controller = PageController(initialPage: 0);

  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 39, 52, 80),
          title: Text(
            "TUK Restaurant",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          elevation: 0.0, //앱바의 입체감을 없애주기위함
          centerTitle: true,
        ),
        drawer: DrawerArea(
          drawerAread: Drawer(),
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
                  "정왕을 담은 레스토랑",
                  style: TextStyle(
                      color: Colors.brown[300],
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
                "원목과 대리석의 자연 친화적 인테리어와 올 데이 다이닝 공간입니다. 라이브 키친에서 신선한 식재료로 즉석에서 조리한 음식을 맛볼 수 있습니다."),
            SizedBox(
              height: 10.0,
            ),
            Column(
              children: [
                Text(
                  "운영시간 ",
                  style: TextStyle(
                      color: Colors.brown[300],
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Image(
                    image: AssetImage(
                        "img/restaurantDetail/restaurant_reservation.PNG"))
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
