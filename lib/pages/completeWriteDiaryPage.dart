import 'package:flutter/material.dart';
import 'package:hy_thon_team3/main.dart';

class CompleteWriteDiaryPage extends StatelessWidget {
  const CompleteWriteDiaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const SizedBox(), // 뒤로가기 버튼 제거
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          width: 326, // 가로 크기
          height: 358, // 세로 크기
          decoration: BoxDecoration(
            color: Colors.white, // 배경색 흰색 설정
            borderRadius: BorderRadius.circular(10), // 모서리를 둥글게 설정
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 5,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '감사합니다!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset(
                  'assets/images/icon_box.png', // 이미지 경로
                  width: 73, // 이미지 크기
                  height: 73,
                  fit: BoxFit.contain, // 이미지 비율 유지
                ),
                const SizedBox(height: 5),
                const Text(
                  '여러분의 글은\n 익명으로\n다른 분께 전달됩니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey,fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => MainPage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          // 페이드 효과 애니메이션
                          const begin = 0.0;
                          const end = 1.0;
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                          var fadeAnimation = animation.drive(tween);

                          return FadeTransition(
                            opacity: fadeAnimation,
                            child: child,
                          );
                        },
                      ),
                          (route) => false, // 이전의 모든 라우트를 제거
                    );
                  },
                  child: const Text(
                    '홈으로',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '다른 분의 사연은 일주일 뒤에 도착합니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Color(0xFF979797)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
