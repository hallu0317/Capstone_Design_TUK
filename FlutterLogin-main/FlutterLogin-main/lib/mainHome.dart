import 'package:flutter/material.dart';
import 'package:flutter_login/auth_controller.dart';

class MainHome extends StatelessWidget {
  String email;
  MainHome({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            email,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[500],
            ),
          ),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.blue[200],
            child: MaterialButton(
              onPressed: () {
                AuthController.instance.logOut();
              },
              child: Center(
                child: Text(
                  "로그아웃",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
