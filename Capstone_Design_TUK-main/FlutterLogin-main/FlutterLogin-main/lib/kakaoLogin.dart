import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';

class FlutterKakaoLoginView extends StatefulWidget {
  const FlutterKakaoLoginView({Key? key}) : super(key: key);

  @override
  _FlutterKakaoLoginViewState createState() => _FlutterKakaoLoginViewState();
}

class _FlutterKakaoLoginViewState extends State<FlutterKakaoLoginView> {
  static final FlutterKakaoLogin kakaoSignIn = FlutterKakaoLogin();
  bool _isLogined = false;
  String _accessToken = '';
  String _refreshToken = '';
  String _accountInfo = '';
  String _loginMessage = 'Not Logged In';

  @override
  void initState() {
    super.initState();
    loadKakao();
  }

  void loadKakao() async {
    // 카카오에서 받은 native app key
    await kakaoSignIn.init('980273fd8f32ef89773a87291945112a');

    // for 안드로이드
    final hashKey = await kakaoSignIn.hashKey;
    print('hashKey: $hashKey');
  }

  Future<void> flutterKakaoLogin() async {
    try {
      final logInResult = await kakaoSignIn.logIn();
      _processLoginResult(logInResult);
    } on PlatformException catch (e) {
      print("${e.code} ${e.message}");
    }
  }

  void _updateAccessToken(String accessToken) {
    setState(() {
      _accessToken = accessToken;
    });
  }

  void _updateRefreshToken(String refreshToken) {
    setState(() {
      _refreshToken = refreshToken;
    });
  }

  void _updateAccountMessage(String message) {
    setState(() {
      _accountInfo = message;
    });
  }

  void _updateStateLogin(bool isLogined, KakaoLoginResult result) {
    setState(() {
      _isLogined = isLogined;
    });
    if (!isLogined) {
      _updateAccessToken('');
      _updateRefreshToken('');
      _updateAccountMessage('');
    } else {
      if (result.token != null && result.token!.accessToken != null) {
        _updateAccessToken(result.token!.accessToken!);
        _updateRefreshToken(result.token!.refreshToken!);
      }
    }
  }

  void _updateLoginMessage(String message) {
    setState(() {
      _loginMessage = message;
    });
  }

  void _processLoginResult(KakaoLoginResult result) {
    switch (result.status) {
      case KakaoLoginStatus.loggedIn:
        _updateLoginMessage('Logged In by the user.');
        _updateStateLogin(true, result);
        break;
      case KakaoLoginStatus.loggedOut:
        _updateLoginMessage('Logged In by the user.');
        _updateStateLogin(false, result);
        break;
      case KakaoLoginStatus.unlinked:
        _updateLoginMessage('Unlinked by the user');
        _updateStateLogin(false, result);
        break;
    }
  }

  Future<void> _unlink() async {
    try {
      final result = await kakaoSignIn.unlink();
      _processLoginResult(result);
    } on PlatformException catch (e) {
      _updateLoginMessage('${e.code}: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  ElevatedButton(
                    child: Text('LogIn'),
                    onPressed: () {
                      flutterKakaoLogin();
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _unlink();
                      },
                      child: Text('Log Out'))
                ],
              ),
              _isLogined
                  ? Text(
                      '로그인 되었습니다.',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                    )
                  : Text('로그아웃 상태 ',
                      style: TextStyle(fontSize: 18.0, color: Colors.black)),
              Text(
                'access_token: $_accessToken',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
              Text(
                'refresh_token: $_refreshToken',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
              Text(
                'accountInfo: $_accountInfo',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
              Text('loginMessage: $_loginMessage',
                  style: TextStyle(fontSize: 18.0, color: Colors.black)),
            ],
          ),
        ));
  }
}
