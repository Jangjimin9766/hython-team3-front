import 'package:flutter/material.dart';
import 'CustomDropdown.dart';

class DiaryInputCard extends StatelessWidget {
  final Function(String?) onDropdown1Changed;
  final Function(String?) onDropdown2Changed;
  final Function(String) onTextChanged;
  final Widget? imagePreview;

  const DiaryInputCard({
    Key? key,
    required this.onDropdown1Changed,
    required this.onDropdown2Changed,
    required this.onTextChanged,
    this.imagePreview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
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
                  onChanged: onDropdown1Changed,
                ),
                const Text(
                  "때문에/덕분에",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                CustomDropdown(
                  initialValue: '힘들었던',
                  items: ['힘들었던', '좋았던', '특별했던'],
                  onChanged: onDropdown2Changed,
                ),
                const Text(
                  "이야기를 들려줄게.",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: '오늘 하루의 이야기를 작성해주세요.',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(16),
              ),
              onChanged: onTextChanged,
            ),
            const SizedBox(height: 16),
            if (imagePreview != null) imagePreview!,
          ],
        ),
      ),
    );
  }
}
