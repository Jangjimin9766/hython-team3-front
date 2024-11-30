import 'package:flutter/material.dart';

class DateSelector extends StatelessWidget {
  final String date;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final VoidCallback? onTap; // 추가된 onTap 콜백
  final bool showArrows; // 화살표 표시 여부 추가

  const DateSelector({
    Key? key,
    required this.date,
    this.onPrevious,
    this.onNext,
    this.onTap, // 선택적 파라미터
    this.showArrows = true, // 기본값은 화살표를 표시
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // onTap 동작 처리
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (showArrows)
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: onPrevious,
              )
            else
              const SizedBox(width: 48), // 화살표 대신 자리 유지
            Text(
              date,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (showArrows)
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: onNext,
              )
            else
              const SizedBox(width: 48), // 화살표 대신 자리 유지
          ],
        ),
      ),
    );
  }
}
