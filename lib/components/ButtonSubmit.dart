import 'package:flutter/material.dart';

class ButtonSubmit extends StatelessWidget {
  final VoidCallback onPressed;

  const ButtonSubmit({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: const Size.fromHeight(48),
      ),
      child: const Text('제출하기', style: TextStyle(color: Colors.white)),
    );
  }
}
