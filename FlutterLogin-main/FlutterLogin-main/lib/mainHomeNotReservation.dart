import 'package:flutter/material.dart';

Widget mainHome2() {
  return Stack(
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
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "체크인: 15:00",
                style: TextStyle(fontSize: 15.0, color: Colors.grey),
              ),
              Text(
                "체크아웃: 12:00",
                style: TextStyle(fontSize: 15.0, color: Colors.grey),
              ),
              Spacer(), //버튼 하단 배치
              IconButton(
                onPressed: () {
                  print("Open!!");
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
  );
}
