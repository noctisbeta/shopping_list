import 'package:flutter/material.dart';
import 'package:shopping_list/constants/colors.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    required this.onChanged,
    this.maxLength,
    super.key,
  });

  final int? maxLength;

  final void Function(String) onChanged;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  String enteredText = '';

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (String value) {
        setState(() {
          enteredText = value;
        });
        widget.onChanged(value);
      },
      maxLength: widget.maxLength,
      maxLines: 1,
      buildCounter: (
        context, {
        required currentLength,
        required isFocused,
        required int? maxLength,
      }) =>
          null,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: kQuaternaryColor,
      ),
      cursorColor: kQuaternaryColor,
      decoration: InputDecoration(
        suffix: switch (widget.maxLength) {
          int() => Text(
              '${enteredText.length}/${widget.maxLength}',
              style: const TextStyle(
                color: kSecondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          null => null,
        },
        focusColor: kPrimaryColor,
        hoverColor: kPrimaryColor,
        labelText: 'Room code',
        labelStyle: const TextStyle(
          color: kSecondaryColor,
          fontWeight: FontWeight.bold,
        ),
        floatingLabelStyle: const TextStyle(
          color: kQuaternaryColor,
          decorationColor: kSecondaryColor,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kSecondaryColor,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kQuaternaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
