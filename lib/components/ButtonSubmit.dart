import 'package:flutter/material.dart';

class ButtonSubmit extends StatelessWidget {
  final VoidCallback? onPressed; // null이면 비활성화
  final bool isEnabled;

  const ButtonSubmit({
    Key? key,
    required this.onPressed,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null, // 비활성화 처리
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? Colors.black : Colors.grey, // 상태에 따라 색상 변경
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        '제출하기',
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
