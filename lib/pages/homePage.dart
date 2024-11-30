import 'package:flutter/material.dart';
import '../helper/shared_preferences_helper.dart'; // SharedPreferencesHelper import
import './writeDairyPage.dart'; // WriteDiaryPage import
import 'signUpPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _accessToken; // 저장된 토큰을 저장할 변수

  @override
  void initState() {
    super.initState();
    _loadAccessToken(); // 토큰 로드
  }

  Future<void> _loadAccessToken() async {
    final token = await SharedPreferencesHelper.getAccessToken();
    setState(() {
      _accessToken = token; // 토큰을 상태에 저장
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F3F3),
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
              '느린 우체국',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                '편지 작성하기',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '당신의\n오늘 이야기를\n들려주세요',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // WriteDiaryPage로 이동
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WriteDiaryPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 100,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          '시작하기',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '누군가의 사연을 일주일 뒤에 받게 됩니다.',
                        style: TextStyle(
                          color: Color(0xFF080808),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '받은 편지함',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
          Card(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 텍스트와 날짜 정렬을 왼쪽으로 설정
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16), // 약간의 상단 및 좌측 여백 추가
                  child: Align(
                    alignment: Alignment.centerLeft, // 컨테이너를 왼쪽으로 정렬
                    child: Container(
                      width: 100, // 원하는 너비로 제한 (예: 80)
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF4E0), // 베이지색 배경
                        borderRadius: BorderRadius.circular(4), // 약간의 모서리 둥글게
                      ),
                      child: const Text(
                        '🕐 24/11/30',
                        textAlign: TextAlign.center, // 날짜 텍스트를 중앙 정렬
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '직장 때문에 힘들었던 하루',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '오늘은 직장에서 참으로 버거운 하루를 보냈다.\n'
                            '아침부터 팀장님께서 갑작스럽게 중요한 프로젝트 보고서를 요구하셨다.\n'
                            '평소에는 충분한 시간을 주셨는데, 이번에는 이유를 묻기도 전에 "오늘 안으로 완료하라"는 지시만 들었다.\n'
                            '내가 맡은 부분뿐만 아니라 동료들이 준비해야 할 자료도 정리해야 해서 혼자 전전긍긍하며 하루를 보냈다.\n'
                            '점심시간도 건너뛰고 겨우 자료를 맞췄지만, 팀장님의 피드백은 예상보다 혹독했다.\n'
                            '결국, 퇴근 시간이 훨씬 지난 저녁 9시가 넘어서야 간신히 보고서를 마무리할 수 있었다.\n'
                            '그럼에도 내일은 더 나아지길 바라며 잠에 들어야겠다.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ],
          ),
        ),
      ),
    );
  }
}
