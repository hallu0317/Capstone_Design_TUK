import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:get/get.dart';
import '../fireStore.dart' as dbName;
import '../payment.dart';

class DeluxDetail extends StatefulWidget {
  const DeluxDetail({Key? key}) : super(key: key);

  @override
  State<DeluxDetail> createState() => _DeluxDetailState();
}

class _DeluxDetailState extends State<DeluxDetail> {
  DateTime _selectedDate_in = DateTime.now();
  DateTime _selectedDate_out = DateTime.now();

  var checkInTime = "";
  var checkOutTime = "";

  final List<String> imgList = [
    "img/deluxDetail/detaildel.jpg",
    "img/deluxDetail/detaildel2.jpg",
    "img/room_img/Deluxe.PNG"
  ];

  final PageController _controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  SizedBox(
                    width: 102,
                  ),
                  Text(
                    "객실상세",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
                color: Colors.black,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("디럭스(Deluxe)",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "TUK Hotel, 체크인 시 배정",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "기준 인원 2명(최대 2명)",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Icon(Icons.apartment),
                        Text("한국공대호텔", style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    Container(
                      // height: size.height / 2,
                      // width: size.width,
                      child: CarouselSlider.builder(
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) =>
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
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  "체크인 시간",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  '12:00',
                                  style: TextStyle(
                                      color: Colors.blue[200], fontSize: 19),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  "|",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "|",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "|",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  "체크아웃 시간",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  '12:00',
                                  style: TextStyle(
                                      color: Colors.blue[200], fontSize: 19),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 15.0),
                        width: 330,
                        height: 60,
                        child: RaisedButton(
                          onPressed: () {
                            Get.to(() => Payment(
                                  email: AuthController
                                      .instance.auth.currentUser!.email!,
                                ));
                          },
                          child: Text(
                            "숙박 예약하기",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "취소규정",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("* 당일 체크인 상품으로 취소 및 환불 불가합니다."),
                          Text("* 단, 호텔의 경우 예약 완료 시점부터 10분 이내 전액 취소 가능합니다."),
                          Text(
                              "* 예약완료 후 10분 이내라도 입실 시간이 경과된 경우, 취소 및 환불 불가합니다."),
                          Text("* 숙박대전 참여 호텔 상품의 경우 '취소불가'로 표기되더라도 객실별 취소규정이"
                              "취소가능으로 제공되는경우 고객센터를 통해 취소가 가능합니다."),
                          Center(
                              child: Text(
                            "고객센터 번호: 031-8041-9999",
                            style: TextStyle(color: Colors.grey),
                          )),
                        ],
                      ),
                    ),
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
