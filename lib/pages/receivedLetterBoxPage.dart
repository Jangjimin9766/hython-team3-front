import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hy_thon_team3/pages/sendedLetterboxPage.dart';
import 'package:intl/intl.dart';

class ReceivedLetterBoxPage extends StatefulWidget {
  const ReceivedLetterBoxPage({Key? key}) : super(key: key);

  @override
  _ReceivedLetterBoxPageState createState() => _ReceivedLetterBoxPageState();
}

class _ReceivedLetterBoxPageState extends State<ReceivedLetterBoxPage> {
  DateTime currentMonth = DateTime.now();
  DateTime selectedDate = DateTime.now();

  // 편지 데이터를 저장할 변수
  String? diaryTitle;
  String? diaryContent;
  bool isLoading = true; // 로딩 상태
  bool hasError = false; // 에러 상태

  @override
  void initState() {
    super.initState();
    _fetchDiary(selectedDate); // 초기 API 호출
  }

  // API 호출 메서드
  Future<void> _fetchDiary(DateTime date) async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    final String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final String url = 'http://43.202.216.82:8080/api/transmission/?date=$formattedDate';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtZW1iZXJJZCI6MSwibWVtYmVyTmFtZSI6IuyGjeuPhCIsImlhdCI6MTczMjg5MTQxNX0.rRAd5FFcc8wgaipwrptCvYXArAO35bMqOvUJNyyYpTw',
        },
      );

      if (response.statusCode == 200) {
        print('API 호출 성공: ${response.statusCode}');
        print('응답 데이터: ${response.body}');

        final data = jsonDecode(utf8.decode(response.bodyBytes));

        if (data['isSuccess'] == true && data['result'] != null) {
          print('데이터 파싱 성공: ${data['result']}');
          setState(() {
            diaryTitle = data['result']['diaryTitle'];
            diaryContent = data['result']['diaryContent'];
            isLoading = false;
          });
        } else {
          print('응답 데이터에 result가 없거나 isSuccess가 false입니다.');
          setState(() {
            diaryTitle = null;
            diaryContent = null;
            isLoading = false;
          });
        }
      } else {
        print('API 호출 실패: 상태 코드 ${response.statusCode}');
        print('응답 데이터: ${response.body}');
        throw Exception('Failed to load diary');
      }
    } catch (e) {
      print('API 호출 중 예외 발생: $e');
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    _fetchDiary(date); // 새로운 날짜에 대한 API 호출
    Navigator.pop(context); // 캘린더 닫기
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // 로딩 중
          : hasError
          ? const Center(child: Text('편지를 불러오는 데 실패했습니다.')) // 에러 발생
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '받은 편지함',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      diaryTitle ?? '받은 편지가 없습니다.',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      diaryContent ?? '',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: diaryTitle != null
                            ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SendedLetterBoxPage(),
                            ),
                          );
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: diaryTitle != null ? Colors.black : Colors.grey,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          '내 편지 보러 가기',
                          style: TextStyle(color: Colors.white),
                        ),
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
