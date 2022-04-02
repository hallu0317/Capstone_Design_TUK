// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:get/get.dart';
import 'googleSignIn.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //컨트롤러
    var _emailController = TextEditingController();
    var _passwordController = TextEditingController();
    var _passwordConfirmController = TextEditingController();
    var _nameController = TextEditingController();
    var _phoneNumberController = TextEditingController();

    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    final _auth = FirebaseAuth.instance;

    final _focusNode = FocusScopeNode();

    String email2 = "";
    String password2 = "";

//DB collection 조회
    final memberCollection = FirebaseFirestore.instance.collection("member");
//회원가입 데이터 디비 저장
    Future updateMemberData() async {
      print("데이터 추가!!");
      return await memberCollection.doc(_emailController.text).set({
        'email': _emailController.text,
        "name": _nameController.text,
        "phone": _phoneNumberController.text,
        "reservation": false,
      });
    }

    @override
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      _passwordConfirmController.dispose();
    }

//비밀번호 일치하지 않을 때 에러처리
    void FlutterDialog() {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              title: Column(
                children: [
                  Text("Error"),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "비밀번호가 일치하지 않습니다.",
                  ),
                ],
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      Get.back();
                      // Get.to(SignUpPage());
                    },
                    child: Text("확인")),
              ],
            );
          });
    }

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Container(
                width: w,
                height: h * 0.125,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("img/Logo.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 0.1),
                  ],
                ),
              ),
              Container(
                width: w,
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: h * 0.05,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          prefixIcon: Icon(
                            Icons.account_circle_rounded,
                            color: Colors.blue[100],
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.blue[100],
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.blue[100],
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                        ),
                        // onChanged: (text) => password2 = text
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextFormField(
                        controller: _passwordConfirmController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password Confirm",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.blue[100],
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                        ),
                        // onChanged: (text) => password2 = text
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextFormField(
                        controller: _phoneNumberController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Phone Number",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          prefixIcon: Icon(
                            Icons.app_settings_alt,
                            color: Colors.blue[100],
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: Container(
                        width: w / 2,
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.blue[200],
                          child: MaterialButton(
                            onPressed: () {
                              if (_passwordController.value ==
                                  _passwordConfirmController.value) {
                                AuthController.instance.register(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim());
                                updateMemberData();
                              }
                              //비밀번호가 일치하지 않으면
                              else {
                                FlutterDialog();
                              }
                            },
                            child: Center(
                              child: Text(
                                "회원가입",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.back(),
                            text: "이미 계정이 존재하나요?",
                            style: TextStyle(
                                fontSize: 20, color: Colors.grey[500])),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
