import 'package:flutter/material.dart';
import 'package:flutter_login/announcement.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/myProfile.dart';
import 'package:flutter_login/myProfileNotReservation.dart';
import 'package:flutter_login/swimming.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'fireStore.dart' as dbName;
import 'mainHome.dart';
import 'widget/appbar_widget.dart';

class reservationCheck extends StatelessWidget {
  const reservationCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 39, 52, 80),
          title: Text(
            "Reservation Check",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          elevation: 0.0, //앱바의 입체감을 없애주기위함
          centerTitle: true,
        ),
        drawer: DrawerArea(
          drawerAread: Drawer(),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const Image(
              image: AssetImage("img/room_img/Single.PNG"),
            ),
            SizedBox(height: 20.0),
            const Text(
              "예약 내역",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            Text(
              "                TUK 호텔 ${dbName.userRoom}\n"
              "체크인/체크아웃 날짜 : ${dbName.checkInDay} ~ ${dbName.checkOutDay}\n"
              "체크인/체크아웃 시간 : 15:00 ~ 12:00",
              style: TextStyle(fontSize: 15.0),
            ),
            SizedBox(height: 10.0),
            Divider(color: Colors.grey, thickness: 1.5),
            Text(
              "예약자 정보",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            Text(
              "이름            ${dbName.userName}\n"
              "전화번호    ${dbName.userPhone}\n"
              "이메일        ${AuthController.instance.auth.currentUser!.email!}",
              style: TextStyle(fontSize: 15.0),
            ),
            SizedBox(height: 10.0),
            Divider(color: Colors.grey, thickness: 1.5),
            Text(
              "결제 내역",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            Text(
              "총 결제금액 : ${dbName.cost}원",
              style: TextStyle(fontSize: 15.0),
            ),
            Divider(color: Colors.grey, thickness: 1.5),
            SizedBox(height: 30.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey, // Background color
              ),
              // style: ButtonStyle(backgroundColor: Colors.accents),
              onPressed: () async {
                print("@@@@@@@@@@@이동");
                Get.to(() => MainHome(
                      email: AuthController.instance.auth.currentUser!.email!,
                    ));
              },
              child: Text(
                "메인화면으로 이동",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
