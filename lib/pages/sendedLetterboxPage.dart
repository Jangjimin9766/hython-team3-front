import 'package:flutter/material.dart';
import '../components/DateSelector.dart';

class SendedLetterBoxPage extends StatelessWidget {
  const SendedLetterBoxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/icon_paper_airplane.png',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            const Text(
              '느린 편지함',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 보낸 편지함 섹션 (위로 이동)
            Text(
              '보낸 편지함',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            // DateSelector 추가
            DateSelector(
              date: '24/11/25',
              onPrevious: () {
                print('이전 날짜');
              },
              onNext: () {
                print('다음 날짜');
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildLetterCard(
                    date: '24/11/25',
                    title: '누군가에게 응원의 메시지를 보냈어요.',
                    content:
                    'Curabitur luctus eros eget nisl auctor, ac tempus ipsum luctus.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 보낸 편지 카드 생성 함수
  Widget _buildLetterCard({
    required String date,
    required String title,
    required String content,
  }) {
    return Card(
      elevation: 2,
      color: Colors.white, // 배경 색상을 흰색으로 설정
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.send, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  date,
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
