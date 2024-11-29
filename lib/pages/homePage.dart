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
      backgroundColor: Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: Color(0xFFF3F3F3),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AccessToken',
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _accessToken ?? '토큰이 없습니다.', // 토큰이 null이면 '토큰이 없습니다.' 표시
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
