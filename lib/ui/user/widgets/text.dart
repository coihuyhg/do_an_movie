import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserText extends StatelessWidget {
  String? text;

  UserText({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: const TextStyle(fontSize: 14, color: Color(0x800F1B2B)),
    );
  }
}
