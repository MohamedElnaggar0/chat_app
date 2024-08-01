// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:scholar_chat/constractor.dart';

// ignore: must_be_immutable
class CustomButtom extends StatelessWidget {
  CustomButtom({Key? key, required this.buttomText, this.ontap})
      : super(key: key);
  final String buttomText;
  VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        height: 50,
        width: double.infinity,
        child: Center(
          child: Text(
            buttomText,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
