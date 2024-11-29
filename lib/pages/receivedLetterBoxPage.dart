import 'package:flutter/material.dart';
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
      body: Padding(
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
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildLetterCard(
                    date: '24/11/25',
                    title: '직장 때문에 힘들었던 하루.',
                    content:
                    'Vivamus ornare metus ut interdum mollis. Donec hendrerit elit at faucibus.',
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
          ],
        ),
      ),
    );
  }
}
