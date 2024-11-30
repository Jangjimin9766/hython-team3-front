import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hy_thon_team3/pages/sendedLetterboxPage.dart';
import 'package:intl/intl.dart';
import '../components/DateSelector.dart';
class ReceivedLetterBoxPage extends StatefulWidget {
  const ReceivedLetterBoxPage({Key? key}) : super(key: key);

  @override
  _ReceivedLetterBoxPageState createState() => _ReceivedLetterBoxPageState();
}

class _ReceivedLetterBoxPageState extends State<ReceivedLetterBoxPage> {
  DateTime currentMonth = DateTime.now(); // 현재 표시 중인 월
  DateTime selectedDate = DateTime.now(); // 선택된 날짜

  // 현재 월의 첫 번째 날
  DateTime get firstDayOfMonth => DateTime(currentMonth.year, currentMonth.month, 1);

  // 현재 월의 마지막 날
  DateTime get lastDayOfMonth =>
      DateTime(currentMonth.year, currentMonth.month + 1, 0);

  // 현재 월의 전체 날짜 (빈칸 포함)
  List<DateTime> get daysInMonth {
    final daysBefore = firstDayOfMonth.weekday % 7; // 첫 날 앞의 빈칸 수
    final daysAfter = 7 - (lastDayOfMonth.weekday % 7) - 1; // 마지막 날 뒤의 빈칸 수
    final totalDays = firstDayOfMonth.subtract(Duration(days: daysBefore));
    final days = List.generate(
      daysBefore + lastDayOfMonth.day + daysAfter,
          (index) => totalDays.add(Duration(days: index)),
    );
    return days;
  }

  // 편지 데이터를 저장할 변수
  String? diaryTitle;
  String? diaryContent;
  bool isLoading = true; // 로딩 상태
  bool hasError = false; // 에러 상태

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
      _fetchDiary(selectedDate); // 날짜 변경 시 API 호출
    });
    Navigator.pop(context); // 캘린더 닫기
  }

// _previousDay와 _nextDay도 API 호출 포함
  void _previousDay() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
      _fetchDiary(selectedDate); // 이전 날짜에 대한 API 호출
    });
  }

  void _nextDay() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
      _fetchDiary(selectedDate); // 다음 날짜에 대한 API 호출
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchDiary(selectedDate); // 초기 API 호출
  }

  // API 호출 메서드
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
          'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtZW1iZXJJZCI6MSwibWVtYmVyTmFtZSI6IuyGjeuPhCIsImlhdCI6MTczMjk0OTMxNX0.hbjBaXcsp3TLXv5zRZ7_d8x0W6DWVI4zR_osiZPGd58',
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
            diaryTitle = null; // 데이터 초기화
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
        diaryTitle = null; // 데이터 초기화
        diaryContent = null;
        hasError = true;
        isLoading = false;
      });
    }
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
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '받은 편지함',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  DateSelector(
                    date: DateFormat('yyyy/MM/dd').format(selectedDate),
                    onPrevious: _previousDay, // 하루 전으로 이동
                    onNext: _nextDay, // 하루 후로 이동
                    onTap: () => _showCalendar(context), // 클릭 시 캘린더 표시
                    showArrows: true, // WriteDiaryPage에서는 화살표 숨김
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
                          // 날짜와 아이콘을 포함한 Row
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 110, // 원하는 너비
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF4E0), // 베이지색 배경
                                borderRadius: BorderRadius.circular(4), // 약간의 모서리 둥글게
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
                                children: [
                                  const Text(
                                    '🕐',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 5), // 아이콘과 날짜 간격
                                  Text(
                                    DateFormat('yy/MM/dd').format(selectedDate), // 날짜 텍스트
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16), // 날짜와 제목 사이 간격
                          // 편지 제목
                          Text(
                            diaryTitle ?? '받은 편지가 없습니다.', // 결과가 없으면 해당 메시지 표시
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16), // 제목과 본문 사이 간격
                          // 편지 내용 (내용이 없으면 비워둠)
                          if (diaryContent != null) ...[
                            Text(
                              diaryContent ?? '', // 본문 텍스트
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 16), // 본문과 버튼 사이 간격
                          ],
                          // "내 편지 보러 가기" 버튼 (항상 렌더링, 비활성화 상태 가능)
                          Align(
                            alignment: Alignment.centerRight, // 버튼 오른쪽 정렬
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
                                  : null, // 제목이 없으면 버튼 비활성화
                              style: ElevatedButton.styleFrom(
                                backgroundColor: diaryTitle != null ? Colors.black : Colors.grey, // 활성화 여부에 따른 색상
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
                  )
                ]
            )

        )

    );
  }

  Widget _buildWeekDays() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Text('SUN', style: TextStyle(color: Colors.grey, fontSize: 14)),
        Text('MON', style: TextStyle(color: Colors.grey, fontSize: 14)),
        Text('TUE', style: TextStyle(color: Colors.grey, fontSize: 14)),
        Text('WED', style: TextStyle(color: Colors.grey, fontSize: 14)),
        Text('THU', style: TextStyle(color: Colors.grey, fontSize: 14)),
        Text('FRI', style: TextStyle(color: Colors.grey, fontSize: 14)),
        Text('SAT', style: TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }
  void _showCalendar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          minChildSize: 0.3,
          builder: (_, controller) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 6,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // 달력 헤더
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                setModalState(() {
                                  currentMonth = DateTime(
                                    currentMonth.year,
                                    currentMonth.month - 1,
                                  );
                                });
                              },
                              icon: const Icon(Icons.chevron_left),
                            ),
                            Text(
                              DateFormat('MMMM yyyy').format(currentMonth),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setModalState(() {
                                  currentMonth = DateTime(
                                    currentMonth.year,
                                    currentMonth.month + 1,
                                  );
                                });
                              },
                              icon: const Icon(Icons.chevron_right),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // 요일 표시
                      _buildWeekDays(),
                      const SizedBox(height: 16),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7, // 7일 주
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: daysInMonth.length,
                          itemBuilder: (context, index) {
                            final day = daysInMonth[index];
                            final isCurrentMonth = day.month == currentMonth.month;
                            final isSelected = day == selectedDate;

                            return GestureDetector(
                              onTap: isCurrentMonth
                                  ? () {
                                setState(() {
                                  selectedDate = day; // DateSelector와 동기화
                                });
                                Navigator.pop(context);
                              }
                                  : null,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFFEBB161)
                                          : Colors.transparent,
                                      shape: BoxShape.circle, // 동그라미 형태
                                    ),
                                    width: 30, // 동그라미 크기 조정
                                    height: 30,
                                    child: Text(
                                      '${day.day}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: isCurrentMonth
                                            ? (isSelected
                                            ? Colors.black
                                            : Colors.grey[800])
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

