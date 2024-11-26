import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String initialValue;
  final List<String> items;
  final ValueChanged<String?>? onChanged;

  const CustomDropdown({
    Key? key,
    required this.initialValue,
    required this.items,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 105, // 드롭다운 너비
      child: DropdownButtonFormField<String>(
        value: initialValue,
        items: items
            .map((String value) => DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              SizedBox(width: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        dropdownColor: Colors.white,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        itemHeight: 50.0,
      ),
    );
  }
}
