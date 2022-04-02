import 'package:flutter/material.dart';

//애니메이션 같은 효과!! 스플래시 줌 첫화면
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.white,
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(
            backgroundColor: Colors.blue[200],
          ),
        ),
      ),
    );
  }
}
