import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserTexField extends StatelessWidget {
  final String image;

  const UserTexField({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        prefixIcon: Image.asset(image),
      ),
    );
  }
}
