import 'package:flutter/material.dart';

class ButtonPickPicture extends StatelessWidget {
  final VoidCallback onPressed;

  const ButtonPickPicture({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: const Size.fromHeight(48),
      ),
      child: const Text('사진첨부', style: TextStyle(color: Colors.white)),
    );
  }
}
