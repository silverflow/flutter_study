import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  const CustomTextField({
    required this.label,
    required this.isTime,
    required this.onSaved,
    required this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          flex: isTime ? 0 : 1,
          child: TextFormField(
            onSaved: onSaved, // 폼 저장했을 때 실행할 함수
            validator: validator, // 폼 검증했을 때 실행할 함수
            cursorColor: Colors.grey, // 커서 색상 변경
            maxLines: isTime ? 1 : null, // 시간 관련 텍스트 필드가 아니면 한 줄 이상 작성 가능
            expands: !isTime, // 시간 관련 텍스트 필드는 공간 최대 차지
            keyboardType:
                isTime ? TextInputType.number : TextInputType.multiline,
            // 시간 관련 텍스트 필드는 기본 숫자 키보드 아니면 일반 글자 키보드 보여주기
            inputFormatters: isTime
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                  ]
                : [], // 시간 관련 텍스트 필드는 숫자만 입력하도록 제한
            decoration: InputDecoration(
              border: InputBorder.none, // 테두리 삭제
              filled: true, // 배경색을 지정하겠다는 선언
              fillColor: Colors.grey[300],
              suffixText: isTime ? '시' : null, // 시간 관련 텍스트 필드는 '시' 접미사 추가
            ),
          ),
        )
      ],
    );
  }
}
