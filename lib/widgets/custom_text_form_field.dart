import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustamTextFormField extends StatelessWidget {
  CustamTextFormField(
      {Key? key,
      required this.hintText,
      this.condition = false,
      this.onChanged})
      : super(key: key);
  final String hintText;
  Function(String)? onChanged;
  bool condition;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is Required';
        }
        return null;
      },
      onChanged: onChanged,
      obscureText: condition,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff76D1FF)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }
}
