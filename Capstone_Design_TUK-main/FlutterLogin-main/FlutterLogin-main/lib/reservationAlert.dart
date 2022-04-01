import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class ReservationAlert extends StatelessWidget {
//   const ReservationAlert({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         RaisedButton(
//             child: Text("예약 여부 확인"),
//             onPressed: () {
//               showDialog(
//                   barrierDismissible: false,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: Text("호텔 예약 여부 확인"),
//                       content: SingleChildScrollView(
//                         child: ListBody(
//                           children: [
//                             Text("예약된 호텔이 있으신가요?"),
//                             Text('네 버튼을 클릭하세요.'),
//                           ],
//                         ),
//                       ),
//                       actions: [
//                         FlatButton(
//                           onPressed: () {
//                             //예약 된 호텔이 있을 때
//                           },
//                           child: Text("네"),
//                         ),
//                         FlatButton(
//                             onPressed: () {
//                               //예약된 호텔이 없을 때
//                             },
//                             child: Text('아니요')),
//                       ],
//                     );
//                   },
//                   context: context);
//             })
//       ],
//     );
//   }
// }

//굳이 쓸 필요 없을듯..?
Widget showDialog2() {
  barrierDismissible:
  false;
  return AlertDialog(
      title: Text("호텔 예약 여부 확인"),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text("예약된 호텔이 있으신가요?"),
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            //예약 된 호텔이 있을 때
          },
          child: Text("네"),
        ),
        FlatButton(
            onPressed: () {
              //예약된 호텔이 없을 때
            },
            child: Text('아니요')),
      ]);
}
