import 'package:flutter/material.dart';

void showSnakeMessenger(BuildContext context, String messeger) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(messeger),
    ),
  );
}
