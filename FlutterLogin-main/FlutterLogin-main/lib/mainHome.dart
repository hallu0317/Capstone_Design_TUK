import 'package:flutter/material.dart';
import 'package:flutter_login/auth_controller.dart';

//MainHome화면
class MainHome extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey(); //Drawer적용시키기 위함
  //로그인한 이메일
  String email;
  MainHome({Key? key, required this.email}) : super(key: key);
  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "TUK-Capstone",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0.0, //앱바의 입체감을 없애주기위함
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        ),
        drawer: drawer(),
        body: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              widget.email,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

//슬라이드 메뉴바
  Drawer drawer() {
    return Drawer(
        child: ListView(
      children: [
        ListTile(
          leading: Icon(
            Icons.home,
            color: Colors.grey[850],
          ),
          title: Text("Home"),
          onTap: () {
            print("홈버튼!!!!");
          },
          trailing: Icon(Icons.add),
        ),
        ListTile(
          leading: Icon(
            Icons.person,
            color: Colors.grey[850],
          ),
          title: Text('My Profile'),
          onTap: () {
            print('profile is clicked');
          },
          trailing: Icon(Icons.add),
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            color: Colors.grey[850],
          ),
          title: Text('Setting'),
          onTap: () {
            print('Setting is clicked');
          },
          trailing: Icon(Icons.add),
        ),
        ListTile(
          leading: Icon(
            Icons.question_answer,
            color: Colors.grey[850],
          ),
          title: Text('Q&A'),
          onTap: () {
            print('Q&A is clicked');
          },
          trailing: Icon(Icons.add),
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Colors.grey[850],
          ),
          title: Text('Logout'),
          onTap: () {
            print('로그아웃');
            AuthController.instance.logOut();
          },
          trailing: Icon(Icons.add),
        ),
      ],
    ));
  }
}

// Material(
//             elevation: 5.0,
//             borderRadius: BorderRadius.circular(30.0),
//             color: Colors.blue[200],
//             child: MaterialButton(
//               onPressed: () {
//                 AuthController.instance.logOut();
//               },
//               child: Center(
//                 child: Text( 
//                   "로그아웃",
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),