import 'package:flutter/material.dart';
import 'package:calendar_scheduler/component/login_text_field.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:provider/provider.dart';
import 'package:calendar_scheduler/provider/schedule_provider.dart';
import 'package:dio/dio.dart';
import 'package:calendar_scheduler/screen/home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Form을 제어할 때 사용되는 GlobalKey. 이 값을 제어하고 싶은
  // Form의 key 매개변수에 입력
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Form을 저장했을 때 이메일을 저장할 프로퍼티
  String email = '';

  // Form을 저장했을 때 비밀번호를 저장할 프로퍼티
  String password = '';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScheduleProvider>();
    onLoginPress(ScheduleProvider provider) async {
      if (!saveAndValidateForm()) {
        return;
      }

      String? message;

      try {
        // register() 함수 대신에 login() 함수를 호출
        await provider.login(email: email, password: password);
      } on DioError catch (e) {
        message = e.response?.data['message'] ?? '알 수 없는 오류가 발생했습니다.';
      } catch (e) {
        message = '알 수 없는 오류가 발생했습니다';
      } finally {
        if (message != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
          ));
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => HomeScreen(),
            ),
          );
        }
      }
    }

    return Scaffold(
      // 좌, 우로 패딩을 줌
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: formKey,
          child: Column(
            // 세로로 중앙 배치
            mainAxisAlignment: MainAxisAlignment.center,
            // 가로는 최대한의 크기로 늘려줌
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/img/logo.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
              const SizedBox(height: 8.0),
              // 로그인 텍스트 필드
              LoginTextField(
                onSaved: (String? val) {
                  email = val!;
                },
                validator: (String? val) {
                  if (val?.isEmpty ?? true) {
                    return '이메일을 입력해주세요.';
                  }

                  // 정규표현식을 이용해 이메일 형식이 맞는지 검사
                  RegExp reg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                  // 이메일 형식이 올바르지 않게 입력됐을 때 에러 메세지
                  if (!reg.hasMatch(val!)) {
                    return '이메일 형식이 올바르지 않습니다.';
                  }

                  // 입력값에 문제가 없다면 null 반환
                  return null;
                },
                hintText: '이메일',
              ),
              const SizedBox(height: 16.0),
              // 비밀번호 텍스트 필드
              LoginTextField(
                onSaved: (String? val) {
                  password = val!;
                },
                validator: (String? val) {
                  if (val?.isEmpty ?? true) {
                    return '비밀번호을 입력해주세요.';
                  }

                  // 입력된 비밀번호가 4자리에서 8자리 사이인지 확인
                  if (val!.length < 4 || val.length > 8) {
                    return '비밀번호는 4~8자 사이로 입력해주세요';
                  }

                  // 입력값에 문제가 없다면 null을 반환
                  return null;
                },
                hintText: '비밀번호',
              ),
              const SizedBox(height: 16.0),
              // 회원가입 버튼
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: SECONDARY_COLOR,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onPressed: () {
                    onRegisterPress(provider);
                  },
                  child: const Text('회원가입')),
              // 로그인 버튼
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: SECONDARY_COLOR,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onPressed: () async {
                    onLoginPress(provider);
                  },
                  child: Text('로그인')),
            ],
          ),
        ),
      ),
    );
  }

  bool saveAndValidateForm() {
    // form을 검증하는 함수를 실행
    if (!formKey.currentState!.validate()) {
      return false;
    }
    // form을 저장하는 함수를 실행
    formKey.currentState!.save();

    return true;
  }

  onRegisterPress(ScheduleProvider provider) async {
    // 미리 만들어둔 함수로 form을 검증
    if (!saveAndValidateForm()) {
      return;
    }

    // 에러가 있을 경우 값을 이 변수에 저장
    String? message;

    try {
      // 회원가입 로직 실행
      await provider.register(email: email, password: password);
    } on DioError catch (e) {
      // 에러가 있을 경우 message 변수에 저장 만약 에러 메세지가 없다면 기본값
      message = e.response?.data['message'] ?? '알 수 없는 오류가 발생했습니다.';
    } catch (e) {
      message = '알 수 없는 오류가 발생했습니다.';
    } finally {
      // 에러 메세지가 null이 아닐 경우 스낵바에 값을 담아서 사용자에게 보여줌
      if (message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      } else {
        // 에러가 없을 경우 홈 스크린으로 이동
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    }
  }
}
