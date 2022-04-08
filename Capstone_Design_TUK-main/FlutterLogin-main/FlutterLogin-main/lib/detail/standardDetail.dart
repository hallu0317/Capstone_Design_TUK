import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class StandardDetail extends StatefulWidget {
  const StandardDetail({Key? key}) : super(key: key);

  @override
  State<StandardDetail> createState() => _StandardDetailState();
}

class _StandardDetailState extends State<StandardDetail> {
  final List<String> imgList = [
    "img/standardDetail/detail1.jpg",
    "img/standardDetail/detail2.jpg",
    "img/standardDetail/detail3.jpg",
    "img/standardDetail/Single.PNG"
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
                    Text("스탠다드(Standard)",
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
