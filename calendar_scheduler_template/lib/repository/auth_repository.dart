import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert';

class AuthRepository {
  // Dio 인스턴스 생성
  final _dio = Dio();
  // 서버 주소
  final _targetUrl =
      'http://${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:3000/auth';

  // 회원가입 로직
  Future<({String refreshToken, String accessToken})> register({
    required String email,
    required String password,
  }) async {
    // 회원가입 URl에 이메일과 비밀번호를 POST 요청으로 보냄
    final result = await _dio.post('$_targetUrl/register/email', data: {
      'email': email,
      'password': password,
    });

    // record 타입으로 토큰을 반환
    return (
      refreshToken: result.data['refreshToken'] as String,
      accessToken: result.data['accessToken'] as String
    );
  }

  // 로그인 로직
  Future<({String refreshToken, String accessToken})> login({
    required String email,
    required String password,
  }) async {
    // 이메일:비밀번호 형태로 문자열 타입으로 구성
    final emailAndPassword = '$email:$password';
    // utf8 인코딩으로부터 base64로 변환할 수 있는 코덱을 생성
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    // emailAndPassword 변수를 base64로 인코딩
    final encoded = stringToBase64.encode(emailAndPassword);

    // 인코딩된 문자열을 헤더에 담아서 로그인 요청을 보냄
    final result = await _dio.post('$_targetUrl/login/email',
        options: Options(headers: {
          'authorization': 'Basic $encoded',
        }));

    // record 타입으로 토큰을 반환
    return (
      refreshToken: result.data['refreshToken'] as String,
      accessToken: result.data['accessToken'] as String
    );
  }

  Future<String> rotateRefreshToken({
    required String refreshToken,
  }) async {
    // 리프레시 토큰을 헤더에 담아서 리프레시 토큰 재발급 URL에 요청을 보냄
    final result = await _dio.post('$_targetUrl/token/refresh',
        options: Options(
          headers: {
            'authorization': 'Bearer $refreshToken',
          },
        ));

    return result.data['accessToken'] as String;
  }

  Future<String> rotateAcessToken({
    required String refreshToken,
  }) async {
    // 리프레시 토큰을 헤더에 담아서 액세스 토큰 재발급 URL에 요청을 보냄
    final result = await _dio.post('$_targetUrl/token/access',
        options: Options(headers: {
          'authorization': 'Bearer $refreshToken',
        }));

    return result.data['acessToken'] as String;
  }
}
