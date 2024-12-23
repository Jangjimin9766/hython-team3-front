import 'package:flutter/material.dart';
import 'package:hy_thon_team3/pages/receivedLetterBoxPage.dart';
import 'package:hy_thon_team3/pages/sendedLetterboxPage.dart';
import 'package:image_picker/image_picker.dart';
import '../components/DateSelector.dart';
import '../components/DiaryInputCard.dart';
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
  int _selectedIndex = 1; // 초기 선택된 탭 (0: 찾기, 1: 홈, 2: 마이페이지)

  // 각 탭에 표시될 페이지들
  static final List<Widget> _pages = <Widget>[
    const SendedLetterBoxPage(),
    const WriteDiaryPage(),
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
              date: '2024/11/30',
              showArrows: false, // WriteDiaryPage에서는 화살표 숨김
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
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => const CompleteWriteDiaryPage(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return child; // 애니메이션 없이 전환
                            },
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
