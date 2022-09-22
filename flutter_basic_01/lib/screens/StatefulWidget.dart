import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  // 클래스를 선언할 때 statefulWidget을 상속받아 생성함
  // StatelessWidget을 상속받은 위젯은 바로 Widget build()를 오버라이드해서 사용한 것과 달리
  // StatefulWidget은 내부에서 사용할 State를 생성하는 것으로 그 역할을 다한다.
  // 나머지는 State에게 맡길 영역이다.
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  // State 또한 플러터 내부에서 선언된 클래스. 상태 앞에 _를 붙이는 것은 관례적 표현
  @override
  void initState() {
    // State 초기화 단계. 필수적으로 오버라이드해야 하는 메서드는 아니며,
    // 상태값에 대한 초기화를 해야하는 경우 사용
    // 이때 super.initState()를 통해 부모 클래스의 initState() 메서드를 함께 실행
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(),
    );
  }

  @override
  void dispose() {
    // 사용된 위젯이 사라질 때 실행되는 단계
    // 앞선 단계에서 사용하던 데이터 등을 정리해야 한다면 dispose() 단계에서 수행 가능
    super.dispose();
  }
}
