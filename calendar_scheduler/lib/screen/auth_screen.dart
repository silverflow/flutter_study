import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 로고 이미지
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.7,
              child: Image.asset(
                'assets/img/logo.png',
              ),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),

          // 구글로 로그인 버튼
          ElevatedButton(
            onPressed: () => onGoogleLoginPress(context),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: SECONDARY_COLOR,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
            child: Text('구글로 로그인'),
          )
        ],
      ),
    ));
  }

  onGoogleLoginPress(BuildContext context) async {
    // 구글 로그인 객체를 생성
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      'email',
    ]);

    try {
      // signIn 함수를 실행해서 로그인을 진행
      GoogleSignInAccount? account = await googleSignIn.signIn();

      // AccessToken과 idToken을 가져올 수 있는 GoogleAignInAuthentication 객체를 불러옴
      final GoogleSignInAuthentication? googleAuth =
          await account?.authentication;

      // AuthCredential 객체를 상속받는 GoogleAuthProvider 객체를 생성
      // accessToken과 idToken만 제공하면 생성됨
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // signInWithCredential() 함수를 이용하면 파이어베이스 인증할 수 있음
      await FirebaseAuth.instance.signInWithCredential(credential);

      // 인증이 끝나면 홈 스크린으로 이동
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => HomeScreen(),
      ));

      // 어떤 값을 반환받는지 출력하여 확인
      print(account);
    } catch (e) {
      // 로그인 에러가 나면 Snackbar를 보여줌
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}
