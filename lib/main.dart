import 'package:flutter/material.dart';
import 'package:hy_thon_team3/pages/receivedLetterBoxPage.dart';
import 'package:hy_thon_team3/pages/sendedLetterboxPage.dart';
import 'widgets/bottom_navbar.dart';
import 'pages/homePage.dart';
import 'pages/OnBoardingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(), //홈을 메인으로
      debugShowCheckedModeBanner: false, // 디폴트로 나타나는 상단 디버그 배너 삭제
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1; // 초기 선택된 탭 (0: 찾기, 1: 홈, 2: 마이페이지)

  // 각 탭에 표시될 페이지들
  static final List<Widget> _pages = <Widget>[
    const SendedLetterBoxPage(), // 찾기 페이지 대신 SendedLetterBoxPage 사용
    const HomePage(),
    const ReceivedLetterBoxPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0), // 위쪽 패딩 20 추가
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          // 버튼 클릭 시 실행할 동작
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OnboardingPage(),
            ),
          );
        },
        backgroundColor: Colors.grey, // 버튼 배경색을 회색으로 설정
        shape: CircleBorder(), // 원형 버튼 강제 설정
        child: Image.asset(
          'assets/images/icon_book.png', // 삽입할 이미지 경로
          fit: BoxFit.contain, // 이미지 비율 유지
          width: 24, // 이미지 너비
          height: 24, // 이미지 높이
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // 우측 하단 배치
    );
  }
}
