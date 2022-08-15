import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:flutter_login/googleSignIn.dart';
import 'package:flutter_login/googleSignInInfo.dart';
import 'package:flutter_login/kakaologin.dart';
import 'package:flutter_login/signup_page.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var keyCheck = 1; //이메일로 로그인됐을 때...
  var checkCheck = 4; //구글 한번 로그인 되었을 때

  //SnS 로그인 image 리스트
  //List images = ["google.png", "twitter.png", "facebook.jpg"];

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
                  height: h * 0.125,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('img/tuklogo.PNG'),
                          radius: 65.0,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Text(
                          "Hotel Service Doorlock",
                          style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 37, 90, 166)),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
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
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color.fromARGB(255, 37, 90, 166),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
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
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color.fromARGB(255, 37, 90, 166),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
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
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Container(
                  height: 40.0,
                  width: w * 0.30,
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(15.0),
                    color: Color.fromARGB(255, 37, 90, 166),
                    child: MaterialButton(
                      onPressed: () {
                        AuthController.instance.login(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                            keyCheck.toString());
                      },
                      child: Center(
                        child: Text(
                          "로그인",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                /*Center(
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
                          onPressed: () async {
                            if (index == 0) {
                              AuthController.instance
                                  .keyCheck(checkCheck.toString());
                              signInWithGoogle();

                              print("구글 로그인 버튼클릭!!");
                            } else if (index == 1) {
                              AuthController.instance
                                  .keyCheck(checkCheck.toString());
                              Kakaologin();
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
                ),*/
                SizedBox(
                  height: w * 0.05,
                ),
                RichText(
                  text: TextSpan(
                    text: "계정이 없으신가요? ",
                    style: TextStyle(color: Colors.grey[500], fontSize: 17),
                    children: [
                      TextSpan(
                          text: " 회원가입",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => SignUpPage())),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Image.asset(
                  "img/epic.PNG",
                  width: 80,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
