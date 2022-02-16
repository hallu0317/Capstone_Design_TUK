import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/auth_controller.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _emailController = TextEditingController();
    var _passwordController = TextEditingController();
    final _auth = FirebaseAuth.instance;

    final _focusNode = FocusScopeNode();

    String email2 = "";
    String password2 = "";

    @override
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
    }

    List images = ["google.png", "twitter.png", "facebook.jpg"];

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          _focusNode.unfocus();
        },
        child: Column(
          children: [
            Container(
              width: w,
              height: h * 0.2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("img/mainTheme.png"),
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
                    height: 80,
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
                      // onChanged: (text) => email2 = text
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
                    height: 90,
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
                            AuthController.instance.register(
                                _emailController.text.trim(),
                                _passwordController.text.trim());
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
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[500])),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.1,
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
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("img/" + images[index]),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
