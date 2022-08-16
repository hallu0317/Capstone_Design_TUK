import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:bootpay_api/bootpay_api.dart';
import 'package:bootpay_api/model/payload.dart';
import 'package:bootpay_api/model/extra.dart';
import 'package:bootpay_api/model/user.dart';
import 'package:bootpay_api/model/item.dart';
import 'package:bootpay_webview_flutter/webview_flutter.dart';
import 'package:flutter_login/reservationCheck.dart';
import 'package:get/get.dart';

class NaverPage extends StatefulWidget {
  @override
  NaverPageState createState() => NaverPageState();
}

class NaverPageState extends State<NaverPage> {
//  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
//    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
//  Future<void> initPlatformState() async {
//    String platformVersion;
//    // Platform messages may fail, so we use a try/catch PlatformException.
//    try {
//      platformVersion = await BootpayApi.platformVersion;
//    } on PlatformException {
//      platformVersion = 'Failed to get platform version.';
//    }
//
//    // If the widget was removed from the tree while the asynchronous platform
//    // message was in flight, we want to discard the reply rather than calling
//    // setState to update our non-existent appearance.
//    if (!mounted) return;
//
//    setState(() {
//      _platformVersion = platformVersion;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          child: RaisedButton(
            onPressed: () {
              goBootpayRequest(context);
            },
            child: Text("부트페이 결제요청"),
          ),
        ));
  }

  void goBootpayRequest(BuildContext context) async {
    Payload payload = Payload();
    payload.androidApplicationId = '623d22ce2701800021f6847f';
    payload.iosApplicationId = '5b8f6a4d396fa665fdc2b5e9';

    // payload.pg = 'nicepay';
    // payload.method = 'npay';
    payload.pg = 'nicepay';
    payload.method = 'npay';
    payload.name = 'testUser';
    payload.price = 1000.0;
    payload.orderId = DateTime.now().millisecondsSinceEpoch.toString();
//    payload.params = {
//      "callbackParam1" : "value12",
//      "callbackParam2" : "value34",
//      "callbackParam3" : "value56",
//      "callbackParam4" : "value78",
//    };

    // User user = User();
    // user.username = "사용자 이름";
    // user.email = "user1234@gmail.com";
    // user.area = "대한민국";
    // user.phone = "010-1234-4567";

    // Extra extra = Extra();
    // extra.appScheme = 'bootpayFlutterSample';

    // Item item1 = Item();
    // item1.itemName = "미\"키's 마우스"; // 주문정보에 담길 상품명
    // item1.qty = 1; // 해당 상품의 주문 수량
    // item1.unique = "ITEM_CODE_MOUSE"; // 해당 상품의 고유 키
    // item1.price = 1000; // 상품의 가격

    // Item item2 = Item();
    // item2.itemName = "키보드"; // 주문정보에 담길 상품명
    // item2.qty = 1; // 해당 상품의 주문 수량
    // item2.unique = "ITEM_CODE_KEYBOARD"; // 해당 상품의 고유 키
    // item2.price = 1000; // 상품의 가격
    // List<Item> itemList = [item1, item2];

    // BootpayApi.request(
    //   context,
    //   payload,
    //   extra: extra,
    //   user: user,
    //   items: itemList,
    // );

    User user = User();
    user.username = "사용자 이름";
    user.email = "user1234@gmail.com";
    user.area = "서울";
    user.phone = "010-1234-4567";

    Extra extra = Extra();
    extra.appScheme = 'bootpaySample';

    Item item1 = Item();
    item1.itemName = "미\"키's 마우스";
    item1.qty = 1; // 해당 상품의 주문 수량
    item1.unique = "ITEM_CODE_MOUSE"; // 해당 상품의 고유 키
    item1.price = 1000; // 상품의 가격

    Item item2 = Item();
    item2.itemName = "키보드"; // 주문정보에 담길 상품명
    item2.qty = 1; // 해당 상품의 주문 수량
    item2.unique = "ITEM_CODE_KEYBOARD"; // 해당 상품의 고유 키
    item2.price = 1000; // 상품의 가격
    List<Item> itemList = [item1, item2];

    BootpayApi.request(context, payload,
        extra: extra,
        user: user,
        items: itemList,
        onDone: (value) => Get.to(() => reservationCheck()));
  }
}
