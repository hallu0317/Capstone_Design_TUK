import 'package:flutter/material.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/fireStore.dart' as dbName;
import 'package:flutter_login/mainHome.dart';
import 'package:get/get.dart';
import 'widget/appbar_widget.dart';
import 'myProfile.dart';

class Announcement extends StatelessWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 39, 52, 80),
        title: Text(
          "AnnounceMent",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevation: 0.0, //앱바의 입체감을 없애주기위함
        centerTitle: true,
      ),
      drawer: DrawerArea(
        drawerAread: Drawer(),
      ),
      body: Column(children: [
        TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text("앱 사용법 안내"),
                    content: new Text("1. 회원가입 진행\n"
                        "2. 로그인\n"
                        "3. 호텔 예약, 결제하기\n"
                        "4. 메인화면에서 도어락 버튼 클릭\n"),
                    actions: [
                      new TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Close"))
                    ],
                  );
                },
              );
            },
            child: Text(
              "1. 앱 사용법",
              style: TextStyle(
                  color: Colors.blue[300],
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )),
        Divider(
          thickness: 1,
          color: Colors.black,
        ),
        TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text("호텔 이용시 유의사항"),
                    content: new Text("도어락 오픈 시 자동 잠김\n"
                        "체크아웃 이후 권한 해제\n"),
                    actions: [
                      new TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Close"))
                    ],
                  );
                },
              );
            },
            child: Text(
              "2. 호텔 이용시 유의 사항",
              style: TextStyle(
                  color: Colors.blue[300],
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )),
        Divider(
          thickness: 1,
          color: Colors.black,
        ),
        TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text("버전 정보"),
                    content: new Text("v22.1.1.0 결제오류 수정\n"
                        "v22.1.1.1 시설이용 추가\n"),
                    actions: [
                      new TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Close"))
                    ],
                  );
                },
              );
            },
            child: Text(
              "3. 버전 정보",
              style: TextStyle(
                  color: Colors.blue[300],
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )),
        Divider(
          thickness: 1,
          color: Colors.black,
        ),
      ]),
    );
  }
}
