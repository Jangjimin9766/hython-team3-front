import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.near_me),
          label: '찾기',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mail),
          label: '마이페이지',
        ),
      ],
      elevation: 0,
      currentIndex: selectedIndex,
      selectedItemColor: Colors.white, // 선택된 아이템의 아이콘 색상: 흰색
      unselectedItemColor: Colors.white, // 선택되지 않은 아이템의 아이콘 색상: 회색
      backgroundColor: Color(0x5C000000), // 배경색: 검정색 36% 투명도
      onTap: onItemTapped,
      selectedIconTheme: IconThemeData(size: 30), // 선택된 아이콘 크기
      unselectedIconTheme: IconThemeData(size: 24), // 선택되지 않은 아이콘 크기
      showSelectedLabels: false, // 선택된 아이템의 라벨 숨김
      showUnselectedLabels: false, // 선택되지 않은 아이템의 라벨 숨김
    );
  }
}
