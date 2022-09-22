import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YES24 BEST 5'),
      ),
      body: ListView(
        children: [
          ListTile(
              // ListView의 한 줄을 나타냄
              title: Text('역행자 (10만 부 기념 페이크 에디션)'), // ListTile 가운데 나타날 위젯
              leading: Image.network(
                // ListTile 맨 앞에 나타날 위젯
                'http://image.yes24.com/goods/109705390/XL',
              )),
          ListTile(
              // ListView의 한 줄을 나타냄
              title: Text('불편한 편의점 2'), // ListTile 가운데 나타날 위젯
              leading: Image.network(
                // ListTile 맨 앞에 나타날 위젯
                'http://image.yes24.com/goods/111088149/XL',
              )),
          ListTile(
              // ListView의 한 줄을 나타냄
              title: Text('하얼빈'), // ListTile 가운데 나타날 위젯
              leading: Image.network(
                // ListTile 맨 앞에 나타날 위젯
                'http://image.yes24.com/goods/111085946/XL',
              )),
          ListTile(
              // ListView의 한 줄을 나타냄
              title: Text('아버지의 해방일지'), // ListTile 가운데 나타날 위젯
              leading: Image.network(
                // ListTile 맨 앞에 나타날 위젯
                'http://image.yes24.com/goods/112253263/XL',
              )),
          ListTile(
              // ListView의 한 줄을 나타냄
              title: Text('엄마의 말 연습'), // ListTile 가운데 나타날 위젯
              leading: Image.network(
                // ListTile 맨 앞에 나타날 위젯
                'http://image.yes24.com/goods/112925092/XL',
              )),
        ],
      ),
    );
  }
}
