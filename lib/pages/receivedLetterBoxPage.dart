import 'package:flutter/material.dart';
import 'package:hy_thon_team3/main.dart';
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

  void _previousDay() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
      if (selectedDate.month != currentMonth.month) {
        currentMonth = DateTime(selectedDate.year, selectedDate.month);
      }
    });
  }

  void _nextDay() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
      if (selectedDate.month != currentMonth.month) {
        currentMonth = DateTime(selectedDate.year, selectedDate.month);
      }
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    Navigator.pop(context); // 캘린더 닫기
    print('선택된 날짜: ${DateFormat('yyyy-MM-dd').format(date)}');
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
            // 받은 편지함 섹션
            Text(
              '받은 편지함',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            // DateSelector 추가
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
                          '바쁜 하루 속에서 느낀 행복',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '오늘도 이른 아침부터 하루가 시작됐다. 새벽 6시, 첫 회원님과의 PT 세션으로 하루를 열었다.\n유난히 열정적이셨던 회원님의 모습에 저도 덩달아 에너지를 얻었다. 함께 땀 흘리며 목표를 향해 나아가는 그 순간들이 저에게는 큰 보람으로 다가온다.\n\n오전에는 단체 필라테스 수업이 있었다. 다 함께 운동을 하며 서로를 응원하는 회원님들의 모습을 보니 마음이 따뜻해졌다.\n이런 긍정적인 에너지가 쌓여서인지, 몸은 피곤해도 마음만은 행복으로 가득 차 있다.\n\n점심시간에는 밀린 상담 일정을 소화했다. 새롭게 시작하려는 분들의 결심과 이야기를 들으며, 제가 그분들의 여정에 함께할 수 있다는 사실이 뿌듯했다.\n이후 오후 시간은 PT 세션과 프로그램 준비로 쉴 틈 없이 흘러갔다.\n\n저녁에는 평소보다 늦게까지 체육관에 남아 회원님들이 남긴 질문에 답하고, 내일을 위한 계획을 세웠다.\n하루 종일 바쁘게 움직였지만, 매 순간 제가 누군가의 건강과 행복을 돕고 있다는 사실이 큰 동기부여가 된다.\n\n비록 육체적으로는 피곤하지만, 오늘도 운동을 통해 많은 사람들에게 긍정적인 변화를 줄 수 있었다는 생각에 미소를 지으며 잠자리에 든다.\n내일도 누군가의 목표를 응원하며 또 다른 행복을 만들어가고 싶다.',
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
                                  if (day.weekday == DateTime.sunday) // 빨간 점 추가
                                    const Padding(
                                      padding: EdgeInsets.only(top: 4.0),
                                      child: Icon(
                                        Icons.circle,
                                        size: 4,
                                        color: Colors.red,
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
                Icon(Icons.access_time, color: Colors.orange), // 노란색 시계 아이콘
                const SizedBox(width: 8),
                Text(
                  date,
                  style: TextStyle(color: Colors.orange), // 텍스트 색상도 노란색
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight, // 버튼을 오른쪽 정렬
              child: ElevatedButton(
                onPressed: () {
                  // WriteDiaryPage로 이동
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => const SendedLetterBoxPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return child; // 애니메이션 없이 바로 전환
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // 둥근 모서리 정의
                  ),
                ),
                child: const Text(
                  '내 편지 보러가기',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
