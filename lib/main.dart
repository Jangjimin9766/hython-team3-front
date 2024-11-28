import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      home: SplashScreen(), // 앱의 첫 화면을 SplashScreen으로 설정
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkOnBoardingStatus();
  }

  // SharedPreferences로 접속 횟수 체크
  Future<void> _checkOnBoardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    int launchCount = prefs.getInt('launchCount') ?? 0; // 접속 횟수 (기본값: 0)

    if (launchCount < 10) {
      // 최초 2회 접속 시 OnboardingPage로 이동
      prefs.setInt('launchCount', launchCount + 1); // 접속 횟수 증가
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingPage()),
      );
    } else {
      // 3회차 이후부터는 MainPage로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // 로딩 화면 표시
      ),
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
    const SendedLetterBoxPage(),
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
        padding: const EdgeInsets.only(top: 20.0),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OnboardingPage()),
          );
        },
        backgroundColor: Colors.grey,
        shape: CircleBorder(),
        child: Image.asset(
          'assets/images/icon_book.png',
          fit: BoxFit.contain,
          width: 24,
          height: 24,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
