import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import '../components/DateSelector.dart';
import '../components/DiaryInputCard.dart';
import '../components/ButtonPickPicture.dart';
import '../components/ButtonSubmit.dart';

class WriteDiaryPage extends StatefulWidget {
  const WriteDiaryPage({Key? key}) : super(key: key);

  @override
  _WriteDiaryPageState createState() => _WriteDiaryPageState();
}

class _WriteDiaryPageState extends State<WriteDiaryPage> {
  XFile? _image;
  final ImagePicker picker = ImagePicker();

  Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.request();
    if (status.isGranted) return true;

    if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('앱 사용을 위해 권한이 필요합니다. 설정에서 허용해주세요.'),
        action: SnackBarAction(label: '설정', onPressed: openAppSettings),
      ));
    }
    return false;
  }

  Future<void> _selectImage(ImageSource source) async {
    final hasPermission = source == ImageSource.camera
        ? await _requestPermission(Permission.camera)
        : await _requestPermission(Permission.photos);

    if (!hasPermission) return;

    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() => _image = pickedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('하루의 이야기', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
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
            imagePreview: _image != null
                ? Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: FileImage(File(_image!.path)),
                  fit: BoxFit.cover,
                ),
              ),
            )
                : null,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top:20,left: 16, bottom: 20),
                  child: ButtonPickPicture(
                    onPressed: () => _selectImage(ImageSource.gallery),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top:20 ,right: 16, bottom: 20),
                  child: ButtonSubmit(
                    onPressed: () => print('첨부된 이미지 경로: ${_image?.path}'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
