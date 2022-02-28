import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/googleSignIn.dart';
import 'package:flutter_login/signup_page.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  //SnS 로그인 image 리스트
  List images = ["google.png", "twitter.png", "facebook.jpg"];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
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
                      image: AssetImage("img/ex1.PNG"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('img/TUK.PNG'),
                          radius: 40.0,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Smart Doorlock",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[400]),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 7,
                                blurRadius: 10,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ]),
                        child: TextField(
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
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
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
                                spreadRadius: 7,
                                blurRadius: 10,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ]),
                        child: TextField(
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
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          // Text(
                          //   "정보를 입력 해 주세요",
                          //   style: TextStyle(
                          //     fontSize: 20,
                          //     color: Colors.grey[500],
                          //   ),
                          // ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50.0,
                  width: w * 0.35,
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.blue[200],
                    child: MaterialButton(
                      onPressed: () {
                        AuthController.instance.login(
                            _emailController.text.trim(),
                            _passwordController.text.trim());
                      },
                      child: Center(
                        child: Text(
                          "로그인",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                      text: "아래 SNS 계정 선택 가능",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Wrap(
                    children: List<Widget>.generate(3, (index) {
                      //구글 로그인
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FlatButton(
                          onPressed: () {
                            if (index == 0) {
                              signInWithGoogle(); //googleSiginIn메소드에 정의 됨
                              print("구글 로그인 버튼클릭!!");
                            } else {
                              print("다른 버튼클릭 됨!");
                            }
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("img/" + images[index]),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: w * 0.05,
                ),
                RichText(
                  text: TextSpan(
                    text: "계정이 없으신가요?",
                    style: TextStyle(color: Colors.grey[500], fontSize: 20),
                    children: [
                      TextSpan(
                          text: " 회원가입",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => SignUpPage())),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
