import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/googleSignInInfo.dart';
import 'package:flutter_login/mainHome.dart';
import 'package:flutter_login/signIn_page.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'fireStore.dart' as userDB;

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  // GoogleSignInInfo info = new GoogleSignInInfo(3);
  // Stream documentStream = FirebaseFirestore.instance
  //     .collection('member')
  //     .doc('${AuthController.instance.auth.currentUser!.email}')
  //     .snapshots();

  late var keyCheck2 = "";
  late var checkCheck2 = "";
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print("로그인 페이지");
      Get.to(() => LoginPage());
    } else {
      print("회원가입 성공!");
      print(keyCheck2);

      // Get.offAll(() => MainHome(email: user.email!));
      if (keyCheck2 == "1") {
        Get.offAll(() => MainHome(email: user.email!));
      } else {
        print(checkCheck2);
        //한번 로그인이 되었을 때 구글 로그인 Info 안되게 하기위해
        // if (documentStream.isEmpty == false) {
        //   Get.offAll(() => MainHome(email: user.email!));
        // } else {
        //   Get.to(() => GoogleSignInInfo());
        // }
        //구글 한번 로그인 되었을 때
        if (checkCheck2 == "4") {
          Get.to(() => MainHome(
                email: user.email!,
              ));
        }
        Get.offAll(() => MainHome(email: user.email!));
        // Get.to(() => GoogleSignInInfo());

        // if (checkCheck2 == 4) {
        //   Get.offAll(() => MainHome(email: user.email!));
        // } else {
        //   Get.to(() => GoogleSignInInfo());
        // }
      }
    }
  }

  void register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.to(() => LoginPage());
    } catch (e) {
      Get.snackbar(
        "About User",
        "User message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text("Account creation failed"),
        messageText: Text(
          e.toString(),
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  void login(String email, String password, String keyCheck) async {
    keyCheck2 = keyCheck;

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      // Get.to(() => LoginPage());
    } catch (e) {
      Get.snackbar(
        "About Login",
        "Login message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text("Login failed"),
        messageText: Text(
          e.toString(),
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  void keyCheck(String check2) async {
    checkCheck2 = check2;
  }

  void logOut() async {
    await auth.signOut();
  }
}
