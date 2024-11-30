import 'package:flutter/material.dart';
import 'package:hy_thon_team3/main.dart';
import 'package:hy_thon_team3/pages/receivedLetterBoxPage.dart';
import 'package:intl/intl.dart';
import '../components/DateSelector.dart';

class SendedLetterBoxPage extends StatefulWidget {
  const SendedLetterBoxPage({Key? key}) : super(key: key);

  @override
  _SendedLetterBoxPageState createState() => _SendedLetterBoxPageState();
}

class _SendedLetterBoxPageState extends State<SendedLetterBoxPage> {
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
            // 보낸 편지함 섹션
            Text(
              '보낸 편지함',
              style: const TextStyle(
                fontSize: 24,
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
                            const SizedBox(width: 5), // 아이콘과 날짜 사이 간격
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
                  ),
                  Container(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '쉴 새 없이 바빴던 하루',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '오늘 하루는 시작부터 정신없이 바빴다.\n아침 7시에 눈을 뜨자마자 밀린 이메일을 확인하고 답장을 보내는 것으로 하루를 시작했다.\n출근길에는 미리 준비해둔 자료를 검토하며 다급하게 오늘의 일정을 정리했다.\n사무실에 도착하자마자 팀원들과의 회의가 이어졌고, 새로운 프로젝트 브리핑을 준비하느라 쉴 틈이 없었다.\n\n점심시간조차 제대로 즐기지 못한 채 간단한 샌드위치로 끼니를 때우고, 다시 업무에 몰두했다.\n오후에는 고객과의 미팅이 이어졌고, 갑작스러운 문제로 추가적인 자료를 준비하느라 예정보다 늦게까지 자리를 지켜야 했다.\n\n퇴근 시간이 되어서야 모든 일이 끝났지만, 이미 에너지는 바닥나 있었다.\n집에 도착해서도 쉬지 못하고 다음 날의 준비를 해야 한다는 압박감에 잠시도 마음을 놓을 수 없었다.\n\n비록 바쁜 하루였지만, 해야 할 일을 하나씩 해결해 나가는 과정에서 작은 성취감도 느낄 수 있었다.\n내일은 오늘보다 조금 더 여유를 가지며 보낼 수 있기를 바라며 하루를 마무리한다.',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
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
                                  pageBuilder: (context, animation, secondaryAnimation) => const ReceivedLetterBoxPage(),
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
                              '답장 보러가기',
                              style: TextStyle(color: Colors.white),
                            ),
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
          ],
        ),
      ),
    );
  }
}
