import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: Image.asset(
                  'assets/img/logo.png',
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => onGoogleLoginPress(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: SECONDARY_COLOR,
              ),
              // textstyle white
              child: Text(
                'Google 계정으로 로그인하기',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onGoogleLoginPress(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
      clientId:
          '284117278019-bclvrq79ltjlveo4o8inhvgno6ljsf7q.apps.googleusercontent.com',
      serverClientId:
          '284117278019-juvc6tkib4iifq5f2co0k7l244je6v4p.apps.googleusercontent.com',
    );

    try {
      GoogleSignInAccount? account = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await account?.authentication;

      // googleAuth 객체가 null이거나 idToken이 null이거나 accessToken이 null이면
      // 인증이 정상적으로 진행된 상태가 아니기 때문에 에러를 던져줌
      if (googleAuth == null ||
          googleAuth.idToken == null ||
          googleAuth.accessToken == null) {
        throw Exception('로그인 실패');
      }

      // 슈파베이스로 소셜 로그인을 진행하는 방법
      await Supabase.instance.client.auth.signInWithIdToken(
          provider: Provider.google,
          idToken: googleAuth.idToken!,
          accessToken: googleAuth.accessToken!);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => HomeScreen(),
        ),
      );
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 실패')),
      );
    }
  }
}
