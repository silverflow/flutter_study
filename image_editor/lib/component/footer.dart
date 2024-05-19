import 'package:flutter/material.dart';

// 스티커를 선택할 때마다 실행할 함수의 시그니처
typedef OnEmotionTap = void Function(int id);

class Footer extends StatelessWidget {
  final OnEmotionTap onEmotionTap;

  const Footer({
    required this.onEmotionTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white.withOpacity(0.9),
        height: 150,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                6,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      onEmotionTap(index + 1); // 스티커 선택할 때 실행할 함수
                    },
                    child: Image.asset(
                      'asset/img/sticker_${index + 1}.png',
                      height: 100,
                    ),
                  ),
                ),
              ),
            )));
  }
}
