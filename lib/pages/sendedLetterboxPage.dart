import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../components/DateSelector.dart';

class SendedLetterBoxPage extends StatefulWidget {
  const SendedLetterBoxPage({Key? key}) : super(key: key);

  @override
  _SendedLetterBoxPageState createState() => _SendedLetterBoxPageState();
}

class _SendedLetterBoxPageState extends State<SendedLetterBoxPage> {
  DateTime selectedDate = DateTime.now(); // 선택된 날짜

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
    final String url = 'http://43.202.216.82:8080/api/diary?date=$formattedDate';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtZW1iZXJJZCI6MSwibWVtYmVyTmFtZSI6IuyGjeuPhCIsImlhdCI6MTczMjk0OTMxNX0.hbjBaXcsp3TLXv5zRZ7_d8x0W6DWVI4zR_osiZPGd58',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));

        if (data['isSuccess'] == true && data['result'] != null) {
          setState(() {
            diaryTitle = data['result']['diaryTitle'];
            diaryContent = data['result']['diaryContent'];
            isLoading = false;
          });
        } else {
          setState(() {
            diaryTitle = null; // 데이터 초기화
            diaryContent = null;
            isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to load diary');
      }
    } catch (e) {
      setState(() {
        diaryTitle = null; // 데이터 초기화
        diaryContent = null;
        hasError = true;
        isLoading = false;
      });
    }
  }

  void _previousDay() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
    });
    _fetchDiary(selectedDate);
  }

  void _nextDay() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
    });
    _fetchDiary(selectedDate);
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    _fetchDiary(selectedDate);
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
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '보낸 편지함',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            DateSelector(
              date: DateFormat('yyyy/MM/dd').format(selectedDate),
              onPrevious: _previousDay,
              onNext: _nextDay,
              onTap: () => _showCalendar(context),
              showArrows: true,
            ),
            const SizedBox(height: 16),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 110,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF4E0),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('🕐'),
                            const SizedBox(width: 5),
                            Text(
                              DateFormat('yy/MM/dd').format(selectedDate),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      diaryTitle ?? '보낸 편지가 없습니다.', // 결과가 없을 경우
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (diaryContent != null)
                      Text(
                        diaryContent!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: diaryTitle != null
                            ? () {
                          Navigator.pop(context);
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: diaryTitle != null
                              ? Colors.black
                              : Colors.grey,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          '받은 편지 보기',
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

  void _showCalendar(BuildContext context) {
    // 캘린더 표시 로직은 생략
  }
}
