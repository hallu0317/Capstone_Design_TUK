import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  late String email;
  MyProfile({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              "$email님 환영합니다.",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}
