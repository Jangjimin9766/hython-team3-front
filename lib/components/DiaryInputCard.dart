import 'package:flutter/material.dart';
import 'CustomDropdown.dart';

class DiaryInputCard extends StatefulWidget {
  final Function(int?) onDropdown1Changed; // 드롭다운 1 인덱스 전달
  final Function(int?) onDropdown2Changed; // 드롭다운 2 인덱스 전달
  final Function(String) onTextChanged;
  final Function(bool) onCharacterCountValid; // 최소 글자수 유효 여부 전달
  final Widget? imagePreview;

  const DiaryInputCard({
    Key? key,
    required this.onDropdown1Changed,
    required this.onDropdown2Changed,
    required this.onTextChanged,
    required this.onCharacterCountValid,
    this.imagePreview,
  }) : super(key: key);

  @override
  _DiaryInputCardState createState() => _DiaryInputCardState();
}

class _DiaryInputCardState extends State<DiaryInputCard> {
  final TextEditingController _textController = TextEditingController();
  int _characterCount = 0;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _characterCount = _textController.text.length;
      });
      widget.onTextChanged(_textController.text);
      widget.onCharacterCountValid(_characterCount >= 50); // 최소 글자 수 확인
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text(
                  "오늘",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                CustomDropdown(
                  initialValue: '직장',
                  items: ['직장', '학업', '가족', '친구', '인간관계', '건강', '날씨', '연애/사랑', '돈', '기타'],
                  onChanged: (value) {
                    final index = ['직장', '학업', '가족', '친구', '인간관계', '건강', '날씨', '연애/사랑', '돈', '기타']
                        .indexOf(value ?? '');
                    widget.onDropdown1Changed(index != -1 ? index : null);
                  },
                ),
                const Text(
                  "때문에/덕분에",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                CustomDropdown(
                  initialValue: '힘들었던',
                  items: ['힘들었던', '좋았던', '특별했던'],
                  onChanged: (value) {
                    final index = ['힘들었던', '좋았던', '특별했던'].indexOf(value ?? '');
                    widget.onDropdown2Changed(index != -1 ? index : null);
                  },
                ),
                const Text(
                  "이야기를 들려줄게.",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Stack(
              children: [
                TextField(
                  controller: _textController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: '오늘 하루의 이야기를 작성해주세요.',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 16,
                  child: Text(
                    '${_characterCount}/400', // 글자수 표시
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
            if (_characterCount < 50)
              const Padding(
                padding: EdgeInsets.only(top: 8, left: 6),
                child: Text(
                  '50자 이상 입력해주세요.', // 경고 메시지
                  style: TextStyle(fontSize: 12, color: Colors.red),
                ),
              ),
            const SizedBox(height: 16),
            if (widget.imagePreview != null) widget.imagePreview!,
          ],
        ),
      ),
    );
  }
}
