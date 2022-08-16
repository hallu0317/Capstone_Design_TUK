import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/announcement.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/fireStore.dart' as dbName;
import 'package:flutter_login/kakaopay.dart';
import 'package:flutter_login/mainHome.dart';
import 'package:flutter_login/myProfile.dart';
import 'package:flutter_login/myProfileNotReservation.dart';
import 'package:flutter_login/naverpay.dart';
import 'widget/appbar_widget.dart';
import 'package:get/get.dart';
import 'bootpay.dart';
import 'package:intl/intl.dart';

class Payment extends StatefulWidget {
  final String email;
  const Payment({Key? key, required this.email}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  DateTime _selectedDate_in = DateTime.now();
  DateTime _selectedDate_out = DateTime.now().add(Duration(days: 1));
  String _inyear = "";
  String _outyear = "";
  String _inday = "";
  String _outday = "";
  String _inmonth = "";
  String _outmonth = "";

  var paymethod = [
    "카카오페이",
    "신용카드",
    "계좌이체",
    "네이버페이",
    "PAYPAL",
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Payment',
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 39, 52, 80),
              title: Text(
                "결제하기",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                              child: Text(
                                "Check In",
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                Future<DateTime?> selected_in = showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate:
                                        DateTime.now().add(Duration(days: 365)),
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Theme(
                                          data: ThemeData.light(),
                                          child: child!);
                                    });
                                selected_in.then((selected_in) {
                                  setState(() {
                                    _selectedDate_in = selected_in!;
                                    _selectedDate_out =
                                        selected_in.add(Duration(days: 1));
                                  });
                                });
                              }),
                          SizedBox(
                            width: 60.0,
                          ),
                          OutlinedButton(
                              child: Text(
                                "Check Out",
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                Future<DateTime?> selected_out = showDatePicker(
                                    context: context,
                                    initialDate:
                                        _selectedDate_in.add(Duration(days: 1)),
                                    firstDate:
                                        _selectedDate_in.add(Duration(days: 1)),
                                    lastDate:
                                        DateTime.now().add(Duration(days: 366)),
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Theme(
                                          data: ThemeData.light(),
                                          child: child!);
                                    });
                                selected_out.then((selected_out) {
                                  setState(() {
                                    _selectedDate_out = selected_out!;
                                  });
                                });
                              }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${_selectedDate_in.month.toString().padLeft(2, '0')}-${_selectedDate_in.day.toString().padLeft(2, '0')}',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown[500]),
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          Text(
                            "~",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown[500]),
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          Text(
                            '${_selectedDate_out.month.toString().padLeft(2, '0')}-${(_selectedDate_out.day).toString().padLeft(2, '0')}',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown[500]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                const Image(
                  image: AssetImage("img/room_img/Single.PNG"),
                ),
                Column(
                  children: [
                    const Text(
                      "결제 정보",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Text(
                      "TUK 호텔 ${dbName.userRoom}",
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      "총 결제금액 : ${dbName.cost}원",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
                Divider(color: Colors.grey, thickness: 1.5),
                Column(
                  children: [
                    Text(
                      "예약자 정보",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Text(
                      "${dbName.userName} / ${dbName.userPhone}",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
                Divider(color: Colors.grey, thickness: 1.5),
                const Text(
                  "결제 수단",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  itemCount: paymethod.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Flexible(
                      child: Card(
                          child: TextButton(
                        onPressed: () {
                          if (paymethod[index] == "카카오페이") {
                            print("카카오페이");
                            kakaoPageState().goBootpayRequest(context);
                            updateMemberData();
                            dbName.userReservation = true;
                          } else if (paymethod[index] == "신용카드") {
                            print("신용카드");
                            TestPageState().goBootpayRequest(context);
                            updateMemberData();
                            dbName.userReservation = true;
                            // Get.to(TestPage());
                          } else if (paymethod[index] == "계좌이체") {
                            print("계좌이체");
                          } else if (paymethod[index] == "네이버페이") {
                            print("네이버페이");
                            NaverPageState().goBootpayRequest(context);
                            updateMemberData();
                            dbName.userReservation = true;
                          } else if (paymethod[index] == "PAYPAL") {
                            print("PAYPAL");
                            dbName.userReservation = true;
                            updateMemberData();
                            updateHotelData();
                          }
                        },
                        child: Text(
                          paymethod[index],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.5,
                          ),
                        ),
                      )),
                    );
                  },
                ),
              ],
            ))));
  }

  final memberCollection = FirebaseFirestore.instance.collection("member");
  final hotelCollection = FirebaseFirestore.instance.collection("hotel");
//회원가입 데이터 디비 저장
  Future updateMemberData() async {
    print("@@reservation 필드 값 변경!!");
    return await memberCollection
        .doc(AuthController.instance.auth.currentUser!.email!)
        .update({
      "reservation": true,
    });
  }

  Future updateHotelData() async {
    print("@@CheckIn,CheckOut 필드 값 변경!!");
    _inyear = DateFormat("yyyy").format(_selectedDate_in);
    _outyear = DateFormat("yyyy").format(_selectedDate_out);
    _inmonth = DateFormat("MM").format(_selectedDate_in);
    _outmonth = DateFormat("MM").format(_selectedDate_out);
    _inday = DateFormat("dd").format(_selectedDate_in);
    _outday = DateFormat("dd").format(_selectedDate_out);
    int uinyear = int.parse(_inyear);
    int uoutyear = int.parse(_outyear);
    int uinday = int.parse(_inday);
    int uoutday = int.parse(_outday);
    int uinmonth = int.parse(_inmonth);
    int uoutmonth = int.parse(_outmonth);
    return await hotelCollection.doc("Standard").update({
      "checkInYear": uinyear,
      "checkOutYear": uoutyear,
      "checkInDay": uinday,
      "checkOutDay": uoutday,
      "checkInMonth": uinmonth,
      "checkOutMonth": uoutmonth,
    });
  }
}
