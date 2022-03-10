import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/fireStore.dart';
import 'package:flutter_login/mainHome.dart';
import 'package:flutter_login/myProfile.dart';
import 'package:flutter_login/regions_reservation.dart';
import 'package:flutter_login/regions.dart';
import 'package:get/get.dart';

class Payment extends StatefulWidget {
  final String email;
  const Payment({Key? key, required this.email}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  DateTime _selectedDate_in = DateTime.now();
  DateTime _selectedDate_out = DateTime.now();
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
              backgroundColor: Colors.grey[400],
              title: Text(
                "결제하기",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
                      'NAME',
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
                      Get.to(MainHome(email: widget.email));
                      print("홈버튼!!!!");
                    },
                  ),
                  ListTile(
                      leading: Icon(Icons.person),
                      title: Text('MyProfile'),
                      onTap: () {
                        print('profile is clicked');
                        Get.to(MyProfile(email: widget.email));
                      }),
                  ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Setting'),
                      onTap: () {
                        print('Setting is clicked');
                      }),
                  ListTile(
                      leading: Icon(Icons.question_answer_outlined),
                      title: Text('Q&A'),
                      onTap: () {
                        print('Q&A is clicked');
                      }),
                  ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                      onTap: () {
                        print('로그아웃');
                        AuthController.instance.logOut();
                      })
                ], //Home, MyProfile, Setting, Q&A, Logout
              ),
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
                            '${_selectedDate_out.month.toString().padLeft(2, '0')}-${_selectedDate_out.day.toString().padLeft(2, '0')}',
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
                    const Text(
                      "TUK 호텔 스탠다드룸",
                      style: TextStyle(fontSize: 15.0),
                    ),
                    const Text(
                      "총 결제금액 : 50000원",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
                Divider(color: Colors.grey, thickness: 1.5),
                Column(
                  children: [
                    const Text(
                      "예약자 정보",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    const Text(
                      "김지원 / 010-1111-2222",
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
                          } else if (paymethod[index] == "신용카드") {
                            print("신용카드");
                          } else if (paymethod[index] == "계좌이체") {
                            print("계좌이체");
                          } else if (paymethod[index] == "네이버페이") {
                            print("네이버페이");
                          } else if (paymethod[index] == "PAYPAL") {
                            print("PAYPAL");
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
                Container(
                  width: w,
                  height: 45,
                  child: RaisedButton(
                    onPressed: () {
                      print("버튼 클릭");
                    },
                    child: Text('50,000원 결제하기'),
                    textColor: Colors.white,
                    elevation: 10,
                    color: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                )
              ],
            ))));
  }
}
