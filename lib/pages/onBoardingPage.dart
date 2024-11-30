import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hy_thon_team3/main.dart';
import 'package:hy_thon_team3/pages/loginPage.dart';
import 'package:hy_thon_team3/pages/signUpPage.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/img_onboarding1.png",
      "title": "느림의 미학, 작은 쉼표",
      "subtitle": "빠르게 지나가는 하루, 잠시 멈춰\n당신의 이야기를 남겨보세요",
    },
    {
      "image": "assets/images/img_onboarding2.png",
      "title": "솔직한 기록, 익명의 대화",
      "subtitle": "누군가의 눈치도, 평가도 없는 공간",
    },
    {
      "image": "assets/images/img_onboarding3.png",
      "title": "시간의 선물, 일주일 후의 위로",
      "subtitle": "당신의 글은 일주일의 시간을 건너\n다른 사람에게 닿습니다",
    },
    {
      "image": "assets/images/img_onboarding4.png",
      "title": "새로운 하루를 시작하는 방법",
      "subtitle": "일주일 전 오늘, 그리고 오늘의 나",
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignUpPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40), // 상단 여백
                    SvgPicture.asset(
                      "assets/images/logo_group.svg", // 로고 이미지 경로
                      width: 65, // 로고 크기 설정
                      height: 65,
                    ),
                    const SizedBox(height: 100), // 로고와 콘텐츠 사이 여백
                    Image.asset(
                      onboardingData[index]["image"]!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      onboardingData[index]["title"]!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      onboardingData[index]["subtitle"]!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
                  (index) => _buildDot(index, context),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.black,
              ),
              onPressed: _nextPage,
              child: Text(
                _currentPage == onboardingData.length - 1 ? "시작하기" : "다음",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.black : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
