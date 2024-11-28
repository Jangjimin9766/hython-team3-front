import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import '../components/DateSelector.dart';
import '../components/DiaryInputCard.dart';
import '../components/ButtonPickPicture.dart';
import '../components/ButtonSubmit.dart';
import './completeWriteDiaryPage.dart';
import '../widgets//bottom_navbar.dart';

class WriteDiaryPage extends StatefulWidget {
  const WriteDiaryPage({Key? key}) : super(key: key);

  @override
  _WriteDiaryPageState createState() => _WriteDiaryPageState();
}

class _WriteDiaryPageState extends State<WriteDiaryPage> {
  XFile? _image;
  final ImagePicker picker = ImagePicker();
  bool _isButtonEnabled = false; // 버튼 활성화 상태
  int _selectedIndex = 1; // BottomNavBar에서 선택된 탭 (1: 다이어리)

  // 이미지 선택 함수
  Future<void> _selectImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  // BottomNavBar 탭 변경 함수
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // 페이지 이동 로직
    if (index == 0) {
      // 찾기 페이지로 이동
      Navigator.pushNamed(context, '/search');
    } else if (index == 1) {
      // 현재 페이지 (홈/다이어리)
    } else if (index == 2) {
      // 마이페이지로 이동
      Navigator.pushNamed(context, '/mypage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: Color(0xFFF3F3F3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('하루의 이야기', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DateSelector(
              date: '2024/11/25',
              onPrevious: () => print('이전 날짜로 이동'),
              onNext: () => print('다음 날짜로 이동'),
            ),
            const SizedBox(height: 16),
            DiaryInputCard(
              onDropdown1Changed: (value) => print('Dropdown1: $value'),
              onDropdown2Changed: (value) => print('Dropdown2: $value'),
              onTextChanged: (text) => print('Text: $text'),
              onCharacterCountValid: (isValid) {
                // 글자 수 유효 여부 업데이트
                setState(() {
                  _isButtonEnabled = isValid;
                });
              },
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
                    child: ButtonSubmit(
                      onPressed: _isButtonEnabled
                          ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CompleteWriteDiaryPage(),
                          ),
                        );
                      }
                          : null, // 버튼 비활성화 처리
                      isEnabled: _isButtonEnabled, // 활성화 여부 전달
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
