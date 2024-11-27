import 'package:flutter/material.dart';
import '../components/DateSelector.dart';

class ReceivedLetterBoxPage extends StatelessWidget {
  const ReceivedLetterBoxPage({Key? key}) : super(key: key);

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
            // 받은 편지함 섹션 (위로 이동)
            Text(
              '받은 편지함',
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
                    title: '직장 때문에 힘들었던 하루.',
                    content:
                    'Vivamus ornare metus ut interdum mollis. Donec hendrerit elit at faucibus fjdsdowdhohqwhdquwdhusgp9dga9wg9dod9wg9dwdisdhsh0dhdwq9wdu9wgd9w9dbb9wbd9ubywqvdwvdvdowqodsdbosudq9bwpbdbpjlshufeb;fb.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 받은 편지 카드 생성 함수
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
                Icon(Icons.access_time, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  date,
                  style: TextStyle(color: Colors.orange),
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
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomRight, // 오른쪽 아래 정렬
              child: Container(
                width: 142,
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    print('내 편지 보러가기 버튼 클릭');
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        '내 편지 보러가기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
