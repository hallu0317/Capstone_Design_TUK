// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// Future<UserCredential> facebookLogin() async {
//   //로그인 flow
//   final LoginResult result = await FacebookAuth.instance.login();

// // //access Token으로부터 권한 발급
// //   final OAuthCredential facebookAuthCredential =
// //       FacebookAuthProvider.credential(result.token);

// //로그인한뒤에 사용자권한을 return
//   return await FirebaseAuth.instance
//       .signInWithCredential(facebookAuthCredential);
// }
